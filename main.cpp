/*
 *
 * Copyright 2022 Apple Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <cassert>
#include <cmath>
#include <iostream>
#include <cstring>
#include <set>
#include <map>

#define NS_PRIVATE_IMPLEMENTATION
#define MTL_PRIVATE_IMPLEMENTATION
#define MTK_PRIVATE_IMPLEMENTATION
#define CA_PRIVATE_IMPLEMENTATION
#include <Metal/Metal.hpp>
#include <AppKit/AppKit.hpp>
#include <MetalKit/MetalKit.hpp>

#include "msdfgen.h"
#include "msdfgen-ext.h"
#include "core/arithmetics.hpp"

#include <simd/simd.h>

using namespace msdfgen;

namespace shader_types {
  struct VertexData {
    simd::float3 position;
    simd::float2 texcoord;
  };
} // namespace shader_types

class Renderer {
  public:
    Renderer( MTL::Device* pDevice );
    ~Renderer();
    void buildShaders();
    void buildBuffers();
    void buildTextures();
    void draw( MTK::View* pView );

  private:
    void generateCircle(const uint8_t trianglesCount, std::vector<shader_types::VertexData>& verts, std::vector<uint16_t>& indices);
    void generateFontPixels(uint8_t* pixelBytes, const uint32_t tw,  const uint32_t th);

    MTL::Device* _pDevice;
    MTL::CommandQueue* _pCommandQueue;
    MTL::RenderPipelineState* _pPSO;
    MTL::Buffer* _pVertexPositionsBuffer;
    MTL::Buffer* _pVertexColorsBuffer;
    MTL::Buffer* _pIndexBuffer;
    MTL::Texture* _pTexture;
};

class MyMTKViewDelegate : public MTK::ViewDelegate {
  public:
    MyMTKViewDelegate( MTL::Device* pDevice );
    virtual ~MyMTKViewDelegate() override;
    virtual void drawInMTKView( MTK::View* pView ) override;

  private:
    Renderer* _pRenderer;
};

class MyAppDelegate : public NS::ApplicationDelegate {
  public:
    ~MyAppDelegate();

    NS::Menu* createMenuBar();

    virtual void applicationWillFinishLaunching( NS::Notification* pNotification ) override;
    virtual void applicationDidFinishLaunching( NS::Notification* pNotification ) override;
    virtual bool applicationShouldTerminateAfterLastWindowClosed( NS::Application* pSender ) override;

  private:
    NS::Window* _pWindow;
    MTK::View* _pMtkView;
    MTL::Device* _pDevice;
    MyMTKViewDelegate* _pViewDelegate = nullptr;
};


int main( int argc, char* argv[] )
{
    NS::AutoreleasePool* pAutoreleasePool = NS::AutoreleasePool::alloc()->init();

    MyAppDelegate del;

    NS::Application* pSharedApplication = NS::Application::sharedApplication();
    pSharedApplication->setDelegate( &del );
    pSharedApplication->run();

    pAutoreleasePool->release();

    return 0;
}


MyAppDelegate::~MyAppDelegate() {
  _pMtkView->release();
  _pWindow->release();
  _pDevice->release();
  delete _pViewDelegate;
}

NS::Menu* MyAppDelegate::createMenuBar() {
  using NS::StringEncoding::UTF8StringEncoding;

  NS::Menu* pMainMenu = NS::Menu::alloc()->init();
  NS::MenuItem* pAppMenuItem = NS::MenuItem::alloc()->init();
  NS::Menu* pAppMenu = NS::Menu::alloc()->init( NS::String::string( "Appname", UTF8StringEncoding ) );

  NS::String* appName = NS::RunningApplication::currentApplication()->localizedName();
  NS::String* quitItemName = NS::String::string( "Quit ", UTF8StringEncoding )->stringByAppendingString( appName );
  SEL quitCb = NS::MenuItem::registerActionCallback( "appQuit", [](void*,SEL,const NS::Object* pSender){
      auto pApp = NS::Application::sharedApplication();
      pApp->terminate( pSender );
  } );

  NS::MenuItem* pAppQuitItem = pAppMenu->addItem( quitItemName, quitCb, NS::String::string( "q", UTF8StringEncoding ) );
  pAppQuitItem->setKeyEquivalentModifierMask( NS::EventModifierFlagCommand );
  pAppMenuItem->setSubmenu( pAppMenu );

  NS::MenuItem* pWindowMenuItem = NS::MenuItem::alloc()->init();
  NS::Menu* pWindowMenu = NS::Menu::alloc()->init( NS::String::string( "Window", UTF8StringEncoding ) );

  SEL closeWindowCb = NS::MenuItem::registerActionCallback( "windowClose", [](void*, SEL, const NS::Object*){
      auto pApp = NS::Application::sharedApplication();
          pApp->windows()->object< NS::Window >(0)->close();
  } );
  NS::MenuItem* pCloseWindowItem = pWindowMenu->addItem( NS::String::string( "Close Window", UTF8StringEncoding ), closeWindowCb, NS::String::string( "w", UTF8StringEncoding ) );
  pCloseWindowItem->setKeyEquivalentModifierMask( NS::EventModifierFlagCommand );

  pWindowMenuItem->setSubmenu( pWindowMenu );

  pMainMenu->addItem( pAppMenuItem );
  pMainMenu->addItem( pWindowMenuItem );

  pAppMenuItem->release();
  pWindowMenuItem->release();
  pAppMenu->release();
  pWindowMenu->release();

  return pMainMenu->autorelease();
}

void MyAppDelegate::applicationWillFinishLaunching( NS::Notification* pNotification ) {
  NS::Menu* pMenu = createMenuBar();
  NS::Application* pApp = reinterpret_cast< NS::Application* >( pNotification->object() );
  pApp->setMainMenu( pMenu );
  pApp->setActivationPolicy( NS::ActivationPolicy::ActivationPolicyRegular );
}

void MyAppDelegate::applicationDidFinishLaunching( NS::Notification* pNotification ) {
  CGRect frame = (CGRect){ {100.0, 100.0}, {512.0, 512.0} };

  _pWindow = NS::Window::alloc()->init(
      frame,
      NS::WindowStyleMaskClosable|NS::WindowStyleMaskTitled,
      NS::BackingStoreBuffered,
      false );

  _pDevice = MTL::CreateSystemDefaultDevice();

  _pMtkView = MTK::View::alloc()->init( frame, _pDevice );
  _pMtkView->setColorPixelFormat( MTL::PixelFormat::PixelFormatBGRA8Unorm_sRGB );
  _pMtkView->setClearColor( MTL::ClearColor::Make( 0.0, 0.0, 1.0, 1.0 ) );

  _pViewDelegate = new MyMTKViewDelegate( _pDevice );
  _pMtkView->setDelegate( _pViewDelegate );

  _pWindow->setContentView( _pMtkView );
  _pWindow->setTitle( NS::String::string( "00 - Window", NS::StringEncoding::UTF8StringEncoding ) );

  _pWindow->makeKeyAndOrderFront( nullptr );

  NS::Application* pApp = reinterpret_cast< NS::Application* >( pNotification->object() );
  pApp->activateIgnoringOtherApps( true );
}

bool MyAppDelegate::applicationShouldTerminateAfterLastWindowClosed( NS::Application* pSender ) {
  return true;
}


MyMTKViewDelegate::MyMTKViewDelegate( MTL::Device* pDevice ) : 
  MTK::ViewDelegate() , _pRenderer( new Renderer( pDevice ) ) {}

MyMTKViewDelegate::~MyMTKViewDelegate() {
  delete _pRenderer;
}

void MyMTKViewDelegate::drawInMTKView( MTK::View* pView ) {
  _pRenderer->draw( pView );
}

Renderer::Renderer( MTL::Device* pDevice ) : _pDevice( pDevice->retain() ) {
  _pCommandQueue = _pDevice->newCommandQueue();
  buildShaders();
  buildBuffers();
  buildTextures();
}

Renderer::~Renderer() {
  _pVertexPositionsBuffer->release();
  _pVertexColorsBuffer->release();
  _pIndexBuffer->release(); 

  _pPSO->release();
  _pTexture->release();
  _pCommandQueue->release();
  _pDevice->release();
}

void Renderer::buildShaders() {
  using NS::StringEncoding::UTF8StringEncoding;

    const char* shaderSrc = R"(
        #include <metal_stdlib>
        #include <metal_common>

        using namespace metal;

        struct v2f
        {
          float4 position [[position]];
          half3 color;
          float2 texcoord;
        };

        struct VertexData {
          float3 position;
          float2 texcoord;
        };

        float median(float r, float g, float b) {
          return max(min(r, g), min(max(r, g), b));
        }

        v2f vertex vertexMain( uint vertexId [[vertex_id]],
                               device const VertexData* vertexData [[buffer(0)]],
                               device const float3* colors [[buffer(1)]] ) {
          v2f out;

          const device VertexData& vd = vertexData[ vertexId ];
          out.position = float4( vd.position, 1.0 );
          out.texcoord = vd.texcoord.xy;
          out.color = half3 ( colors[ vertexId ] );
          return out;
        }

        half4 fragment fragmentMain(v2f in [[stage_in]], 
          texture2d< half, access::sample > tex [[texture(0)]] ) {
            constexpr sampler textureSampler(filter::linear, filter::linear);
            half3 texel = tex.sample(textureSampler, in.texcoord).rgb;
            float sd = median(texel.r, texel.g, texel.b);

            float screenPxDistance = (256/32 * 4) * (sd - 0.5);

            float alpha = clamp(screenPxDistance + 0.5, 0.0, 1.0);
            half4 bgColor = half4(0.0, 0.0, 1.0, 0.0);
            half4 fontColor = half4(0.0, 0.0, 0.0, 1.0);
            half4 tot = mix(fontColor, bgColor, alpha);
		
            return tot;
        }
    )";

    NS::Error* pError = nullptr;
    MTL::Library* pLibrary = _pDevice->newLibrary( NS::String::string(shaderSrc, UTF8StringEncoding), nullptr, &pError );
    if ( !pLibrary )
    {
        __builtin_printf( "%s", pError->localizedDescription()->utf8String() );
        assert( false );
    }

    MTL::Function* pVertexFn = pLibrary->newFunction( NS::String::string("vertexMain", UTF8StringEncoding) );
    MTL::Function* pFragFn = pLibrary->newFunction( NS::String::string("fragmentMain", UTF8StringEncoding) );

    MTL::RenderPipelineDescriptor* pDesc = MTL::RenderPipelineDescriptor::alloc()->init();
    pDesc->setVertexFunction( pVertexFn );
    pDesc->setFragmentFunction( pFragFn );
    pDesc->colorAttachments()->object(0)->setPixelFormat( MTL::PixelFormat::PixelFormatBGRA8Unorm_sRGB );

    _pPSO = _pDevice->newRenderPipelineState( pDesc, &pError );
    if ( !_pPSO )
    {
        __builtin_printf( "%s", pError->localizedDescription()->utf8String() );
        assert( false );
    }

    pVertexFn->release();
    pFragFn->release();
    pDesc->release();
    pLibrary->release();
}

void Renderer::buildBuffers() {
    // https://cs.opensource.google/fuchsia/fuchsia/+/main:src/ui/lib/escher/shape/mesh.h;l=19
    // create a Mesh class that contains indices, position, color buffers
    // use command buffers with retained references or let MTLBuffer 
    // objects live long enough so that they aren't deallocated before 
    // any command buffer that's still using them completes
    const size_t NumVertices = 6;

    // Remove dupes because we can index them from indices array
    shader_types::VertexData verts [NumVertices] = {
      {{ -0.5f, -0.5f, 0.0f }, { 0.0f, 1.0f }},
      {{ -0.5f,  0.5f, 0.0f }, { 0.0f, 0.0f }},
      {{  0.5f,  0.5f, 0.0f }, { 1.0f, 0.0f }},
      {{  0.5f, -0.5f, 0.0f }, { 1.0f, 1.0f }},
    };

    simd::float3 colors[NumVertices] = {
      {  1.0, 0.3f, 0.0f },
      {  0.8f, 1.0, 0.0f },
      {  0.8f, 0.0f, 0.0f },
    };

    uint16_t indices[NumVertices] = { 0, 1, 2, 0, 2, 3 };

    const size_t verticesDataSize = NumVertices * sizeof(shader_types::VertexData);
    const size_t colorDataSize = NumVertices * sizeof(simd::float3);
    const size_t indicesDataSize = NumVertices * sizeof(uint16_t);


    MTL::Buffer* pVertexPositionsBuffer = _pDevice->newBuffer( verticesDataSize, MTL::ResourceStorageModeManaged );
    MTL::Buffer* pVertexColorsBuffer = _pDevice->newBuffer( colorDataSize, MTL::ResourceStorageModeManaged );
    MTL::Buffer* pIndexBuffer = _pDevice->newBuffer( indicesDataSize, MTL::ResourceStorageModeManaged );

    _pVertexPositionsBuffer = pVertexPositionsBuffer;
    _pVertexColorsBuffer = pVertexColorsBuffer;
    _pIndexBuffer = pIndexBuffer;

    memcpy( _pVertexPositionsBuffer->contents(), verts, verticesDataSize );
    memcpy( _pVertexColorsBuffer->contents(), colors, colorDataSize );
    memcpy(_pIndexBuffer->contents(), indices, indicesDataSize);
  

    _pVertexPositionsBuffer->didModifyRange( NS::Range::Make( 0, _pVertexPositionsBuffer->length() ) );
    _pVertexColorsBuffer->didModifyRange( NS::Range::Make( 0, _pVertexColorsBuffer->length() ) );
    _pIndexBuffer->didModifyRange( NS::Range::Make( 0, _pIndexBuffer->length() ) );
}

void Renderer::generateFontPixels(uint8_t* pixelBytes, const uint32_t tw,  const uint32_t th) {

  FreetypeHandle *ft = initializeFreetype();
  char constexpr glpyh = 'A';

  if (ft) {
    FontHandle *font = loadFont(ft, "./resources/NewYork.ttf");
    if (font) {
      Shape shape;
      if (loadGlyph(shape, font, glpyh)) {
        shape.normalize();
        edgeColoringSimple(shape, 3.0);
        Bitmap<float, 3> msdf(tw, th);
        generateMSDF(msdf, shape, 4.0, 1.0, Vector2(4.0, 4.0));

        for (int y = 0; y < msdf.height(); ++y) {
          for (int x = 0; x < msdf.width(); ++x) {
            size_t i = (msdf.height() - 1 - y) * tw + x;
            pixelBytes[i*4+0] = clamp(256.f*msdf(x, y)[0], 255.f);
            pixelBytes[i*4+1] = clamp(256.f*msdf(x, y)[1], 255.f);
            pixelBytes[i*4+2] = clamp(256.f*msdf(x, y)[2], 255.f);
            pixelBytes[i*4+3] = clamp(256.f*msdf(x, y)[3], 255.f);
          }
        }
      }
    }
  }
}

void Renderer::buildTextures() {
  const uint32_t tw = 32;
  const uint32_t th = 32;

  MTL::TextureDescriptor* pTextureDesc = MTL::TextureDescriptor::alloc()->init();
  pTextureDesc->setWidth( tw );
  pTextureDesc->setHeight( th );
  pTextureDesc->setPixelFormat( MTL::PixelFormatRGBA8Unorm_sRGB );
  pTextureDesc->setTextureType( MTL::TextureType2D );
  pTextureDesc->setStorageMode( MTL::StorageModeShared );
  pTextureDesc->setUsage( MTL::ResourceUsageSample | MTL::ResourceUsageRead );

  MTL::Texture *pTexture = _pDevice->newTexture( pTextureDesc );
  _pTexture = pTexture;

  // MSDFGEN
  uint8_t pixelBytes[tw * th * 4];
  size_t old_sz = tw * 4;
  generateFontPixels(pixelBytes, tw, th);

  _pTexture->replaceRegion( MTL::Region( 0, 0, 0, tw, th, 1 ), 0, pixelBytes, old_sz);

  pTextureDesc->release();
}

void Renderer::draw( MTK::View* pView ) {
  NS::AutoreleasePool* pPool = NS::AutoreleasePool::alloc()->init();

  MTL::CommandBuffer* pCmd = _pCommandQueue->commandBuffer();
  MTL::RenderPassDescriptor* pRpd = pView->currentRenderPassDescriptor();

  // one encoder = single pass
  MTL::RenderCommandEncoder* pEnc = pCmd->renderCommandEncoder( pRpd );

  // if you have an array of Mesh objects, you can iterate 
  // and set below functions for each object
  pEnc->setRenderPipelineState(_pPSO);
  pEnc->setVertexBuffer(_pVertexPositionsBuffer,0,0);
  pEnc->setVertexBuffer(_pVertexColorsBuffer,0,1);
  pEnc->setVertexBuffer(_pIndexBuffer,0,2);
  pEnc->setFragmentTexture(_pTexture, 0);
  // vertex shader function gets [0-N] vertices
  // pEnc->drawPrimitives( MTL::PrimitiveType::PrimitiveTypeTriangle, NS::UInteger(0), NS::UInteger(6) );
  pEnc->drawIndexedPrimitives(MTL::PrimitiveType::PrimitiveTypeTriangle, 6, MTL::IndexType::IndexTypeUInt16, _pIndexBuffer, 0);

  pEnc->endEncoding();
  pCmd->presentDrawable( pView->currentDrawable() );
  pCmd->commit();

  pPool->release();
}
