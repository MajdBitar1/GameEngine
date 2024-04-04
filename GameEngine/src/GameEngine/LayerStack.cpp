#include "gepch.h"
#include "LayerStack.h"

namespace GameEngine {
	LayerStack::LayerStack() {
		m_LayerInsert = m_Layers.begin();
	}
	LayerStack::~LayerStack()
	{
		for (Layer* layer : m_Layers)
			delete layer;
	}

	// layersa re pushed into the first half of the list 
	void LayerStack::PushLayer(Layer* layer)
	{
		m_LayerInsert = m_Layers.emplace(m_LayerInsert, layer);
	}

	void LayerStack::PushOverlay(Layer* overlay)
	{
		m_Layers.emplace_back(overlay);
	}

	void LayerStack::PopLayer(Layer* layer)
	{
		auto it = std::find(m_Layers.begin(), m_Layers.end(), layer);
		if (it != m_Layers.end())
		{
			m_Layers.erase(it);
			m_LayerInsert--;
		}
	}

	//overlays are push into the second half of the list
	void LayerStack::PopOverlay(Layer* overlay)
	{
		auto it = std::find(m_Layers.begin(), m_Layers.end(), overlay);
		if (it != m_Layers.end())
			m_Layers.erase(it);
	}
}


// layer stack owns the layers, layer stack is owned by application 
// when we pop a layer out of the stack the layer is NOT destroyed, it is still allocated
// when the application terminates, the layerstack terminates and thus every layer is destroyed then