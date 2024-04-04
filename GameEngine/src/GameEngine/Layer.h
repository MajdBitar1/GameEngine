#pragma once

#include "GameEngine/Core.h"
#include "GameEngine/Events/Event.h"
namespace GameEngine {
	class GE_API Layer {
	public:
		Layer(const std::string& name = "Layer"); //constructor by default name is Layer, Layer names aer used for debug only, in a real application it is better to ref layers by Nber!
		virtual ~Layer(); //Destructor

		virtual void OnAttach() {}
		virtual void OnDetach() {}
		virtual void OnUpdate() {}
		virtual void OnEvent(Event& event) {}

		inline const std::string& GetName() const { return m_DebugName; }
	protected:
		std::string m_DebugName;
	};
}

