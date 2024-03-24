#pragma once

#ifdef GE_PLATFORM_WINDOWS

extern GameEngine::Application* GameEngine::CreateApplication();

int main(int argc,char** argv)
{
	GameEngine::Log::Init();
	GE_CORE_WARN("INIT LOG!");
	int a = 5;
	GE_INFO("INIT LOG ={0}!",a);
	auto app = GameEngine::CreateApplication();
	app->Run();
	delete app;
}

#endif