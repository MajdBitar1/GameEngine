workspace "GameEngine"

    architecture "x64"
    
    configurations
    {
        "Debug",    
        "Release",  
        "Dist"      
    }
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

--Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "GameEngine/vendor/GLFW/include"
IncludeDir["Glad"] = "GameEngine/vendor/Glad/include"
IncludeDir["ImGui"] = "GameEngine/vendor/imgui"

include "GameEngine/vendor/GLFW"
include "GameEngine/vendor/Glad"
include "GameEngine/vendor/imgui"

project "GameEngine"
    location "GameEngine"
    kind "SharedLib"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    pchheader "gepch.h"
    pchsource "GameEngine/src/gepch.cpp"
    
    staticruntime "on" 
    files 
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "%{prj.name}/src",
        "%{prj.name}/vendor/spdlog/include",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.ImGui}",

    }

    links 
    {
        "GLFW",
        "Glad",
        "ImGui",
        "opengl32.lib",
        "dwmapi.lib",
    }
    
    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"
    
        defines
        {
            "GE_PLATFORM_WINDOWS",
            "GE_BUILD_DLL",
            "GLFW_INCLUDE_NONE"
        }

    postbuildcommands
    {
        ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
    }

    filter "configurations:Debug"
        defines "GE_DEBUG"
        buildoptions "/MDd"
        symbols "On"
    filter "configurations:Release"
        defines "GE_RELEASE"
        buildoptions "/MD"
        optimize "On"
    filter "configurations:Dist"
        defines "GE_DIST"
        buildoptions "/MD"
        optimize "On"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    staticruntime "on" 
    files 
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "GameEngine/vendor/spdlog/include",
        "GameEngine/src"
    }

    links
    {
        "GameEngine"
    }

    filter "system:windows"
        cppdialect "C++20"
        staticruntime "On"
        systemversion "latest"
    
        defines
        {
            "GE_PLATFORM_WINDOWS"
        }
    
    filter "configurations:Debug"
        defines "GE_DEBUG"
        buildoptions "/MDd"
        symbols "On"
    filter "configurations:Release"
        defines "GE_RELEASE"
        buildoptions "/MD"
        optimize "On"
    filter "configurations:Dist"
        defines "GE_DIST"
        buildoptions "/MD"
        optimize "On"

    
