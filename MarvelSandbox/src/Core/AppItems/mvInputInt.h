#pragma once

#include "Core/mvAppItem.h"

namespace Marvel {

	class mvInputInt : public mvIntItemBase
	{

	public:

		MV_APPITEM_TYPE(mvAppItemType::InputInt)

		mvInputInt(const std::string& parent, const std::string& name, int default_value)
			: mvIntItemBase(parent, name, 1, default_value){}

		virtual void draw() override
		{

			if (ImGui::InputInt(m_label.c_str(), m_value))
				mvApp::GetApp()->triggerCallback(m_callback, m_name);

		}

	};

}