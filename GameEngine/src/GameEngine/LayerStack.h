#pragma once

#include "GameEngine/Core.h"
#include "Layer.h"
#include "vector"


namespace GameEngine {

	class GE_API LayerStack {
	public:
		LayerStack(); //constr
		~LayerStack(); //Dest

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* overlay);
		void PopLayer(Layer* layer);
		void PopOverlay(Layer* overlay);

		std::vector<Layer*>::iterator begin() { return m_Layers.begin(); }
		std::vector<Layer*>::iterator end() { return m_Layers.end(); }
	private:
		std::vector<Layer*> m_Layers;
		std::vector<Layer*>::iterator m_LayerInsert;
	};
}

