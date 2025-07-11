// swift-tools-version: 5.6
import PackageDescription
    
var sources = [
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml.c",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/gguf.cpp", 
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-quants.c",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-alloc.c",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-backend.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-threading.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-backend-reg.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-metal/ggml-metal.m",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-blas/ggml-blas.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-aarch64.c",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-cpu/ggml-cpu-aarch64.c",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-cpu/ggml-cpu.c",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-cpu/ggml-cpu.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-cpu/ggml-cpu-quants.c",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-cpu/ggml-cpu-traits.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/ggml/src/ggml-cpu/llamafile/sgemm.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/unicode.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/unicode-data.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-grammar.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-vocab.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-sampling.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-context.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-kv-cache.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-mmap.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-quant.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-model.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-model-loader.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-impl.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-cparams.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-hparams.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-chat.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-batch.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-arch.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/src/llama-adapter.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/common/common.cpp", 
    "Sources/llmfarm_core_cpp/llama.cpp/common/log.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/common/arg.cpp",  
    "Sources/llmfarm_core_cpp/llama.cpp/common/json-schema-to-grammar.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/common/sampling.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/examples/llava/llava.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/examples/llava/clip.cpp",
    "Sources/llmfarm_core_cpp/llama.cpp/examples/llava/llava-cli.cpp",
    "Sources/llmfarm_core_cpp/gpt_spm.cpp",
    "Sources/llmfarm_core_cpp/package_helper.m",
    "Sources/llmfarm_core_cpp/exception_helper_objc.mm",  
    "Sources/llmfarm_core_cpp/exception_helper.cpp",
]
    
var cSettings: [CSetting] = [
    .define("SWIFT_PACKAGE"),
    .define("GGML_USE_ACCELERATE"),
    .define("GGML_USE_METAL"),
    .headerSearchPath("llama.cpp/common"),
    .headerSearchPath("llama.cpp/include"),
    .headerSearchPath("llama.cpp/ggml/include"),
    .headerSearchPath("llama.cpp/ggml/src"),
    .headerSearchPath("llama.cpp/ggml/src/ggml-cpu"),
]
            
var linkerSettings: [LinkerSetting] = [
    .linkedFramework("Foundation"),
    .linkedFramework("Accelerate"),
    .linkedFramework("Metal"),
    .linkedFramework("MetalKit"),
]
   
let package = Package(
    name: "llmfarm_core",
    platforms: [.macOS(.v11), .iOS(.v14)],   
    products: [   
        .library(
            name: "llmfarm_core",
            targets: ["llmfarm_core"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "llmfarm_core",  
            dependencies: ["llmfarm_core_cpp"],
            path: "Sources/llmfarm_core"),
        .target(
            name: "llmfarm_core_cpp",
            path: "Sources/llmfarm_core_cpp",
            sources: sources,
            publicHeadersPath: "spm-headers",
            cSettings: cSettings,
            linkerSettings: linkerSettings
        ),
    ],
    cxxLanguageStandard: .cxx17
)
