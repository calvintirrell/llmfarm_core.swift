// swift-tools-version: 5.6
import PackageDescription
    
var sources = [
    "llama.cpp/ggml/src/ggml.c",
    "llama.cpp/ggml/src/gguf.cpp",
    "llama.cpp/ggml/src/ggml-quants.c",
    "llama.cpp/ggml/src/ggml-alloc.c",
    "llama.cpp/ggml/src/ggml-backend.cpp",
    "llama.cpp/ggml/src/ggml-threading.cpp",
    "llama.cpp/ggml/src/ggml-backend-reg.cpp",
    "llama.cpp/ggml/src/ggml-metal/ggml-metal.m",
    "llama.cpp/ggml/src/ggml-blas/ggml-blas.cpp",
    "llama.cpp/ggml/src/ggml-aarch64.c",
    "llama.cpp/ggml/src/ggml-cpu/ggml-cpu-aarch64.c",
    "llama.cpp/ggml/src/ggml-cpu/ggml-cpu.c",
    "llama.cpp/ggml/src/ggml-cpu/ggml-cpu.cpp",
    "llama.cpp/ggml/src/ggml-cpu/ggml-cpu-quants.c",
    "llama.cpp/ggml/src/ggml-cpu/ggml-cpu-traits.cpp",
    "llama.cpp/ggml/src/ggml-cpu/llamafile/sgemm.cpp",
    "llama.cpp/src/llama.cpp",
    "llama.cpp/src/unicode.cpp",
    "llama.cpp/src/unicode-data.cpp",
    "llama.cpp/src/llama-grammar.cpp",
    "llama.cpp/src/llama-vocab.cpp",
    "llama.cpp/src/llama-sampling.cpp",
    "llama.cpp/src/llama-context.cpp",
    "llama.cpp/src/llama-kv-cache.cpp",
    "llama.cpp/src/llama-mmap.cpp",
    "llama.cpp/src/llama-quant.cpp",
    "llama.cpp/src/llama-model.cpp",
    "llama.cpp/src/llama-model-loader.cpp",
    "llama.cpp/src/llama-impl.cpp",
    "llama.cpp/src/llama-cparams.cpp",
    "llama.cpp/src/llama-hparams.cpp",
    "llama.cpp/src/llama-chat.cpp",
    "llama.cpp/src/llama-batch.cpp",
    "llama.cpp/src/llama-arch.cpp",
    "llama.cpp/src/llama-adapter.cpp",
    "llama.cpp/common/common.cpp",
    "llama.cpp/common/log.cpp",
    "llama.cpp/common/arg.cpp",
    "llama.cpp/common/json-schema-to-grammar.cpp",
    "llama.cpp/common/sampling.cpp",
    "llama.cpp/examples/llava/llava.cpp",
    "llama.cpp/examples/llava/clip.cpp",
    "llama.cpp/examples/llava/llava-cli.cpp",
    "gpt_spm.cpp",
    "package_helper.m",
    "exception_helper_objc.mm",
    "exception_helper.cpp",
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
