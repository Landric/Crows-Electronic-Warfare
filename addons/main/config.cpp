#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main", "zen_main"};
        author = "Crowdedlight";
        VERSION_CONFIG;
    };
};

PRELOAD_ADDONS;

#include "CfgEventhandlers.hpp"