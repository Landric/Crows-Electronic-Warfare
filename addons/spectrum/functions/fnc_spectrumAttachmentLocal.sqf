#include "script_component.hpp"
/*/////////////////////////////////////////////////
Author: Crowdedlight
			   
File: fnc_spectrumAttachmentLocal.sqf
Parameters: 
Return: 

Script being called by PFH to handle updates for frequencies depending on what attachment is used

*///////////////////////////////////////////////

// exit if spectrum analyzer is not equipped. 
if (!("hgun_esd_" in (handgunWeapon player))) exitWith {}; 

private _muzzleAttachment = (handgunItems player) select 0;

// don't reset vars and calculate if we have same attachment as last time, should make us only recalculate upon changes
if (GVAR(LastSpectrumMuzzleAttachment) == _muzzleAttachment) exitWith {};

private _minFreq = 0;
private _maxFreq = 0;

switch (_muzzleAttachment) do {
	// 78 - 89 MHz - consider changing to 30 - 389 mhz, for TFAR frequencie ranges
	case "muzzle_antenna_01_f": {
		GVAR(spectrumRangeAntenna) = 1;
		_minFreq = 30;
		_maxFreq = 389;
	};
	// 390 - 500 MHz
	case "muzzle_antenna_02_f": {
		GVAR(spectrumRangeAntenna) = 2;
		_minFreq = 390;
		_maxFreq = 500;
	};
	// 433 MHz - UVG jamming antenna 
	case "muzzle_antenna_03_f": {
		GVAR(spectrumRangeAntenna) = 3;
		_minFreq = 433;
		_maxFreq = 440;
	};
	default {
		GVAR(spectrumRangeAntenna) = -1;
	};
};

GVAR(LastSpectrumMuzzleAttachment) = _muzzleAttachment;

// set local params
missionNamespace setVariable ["#EM_FMin", _minFreq];
missionNamespace setVariable ["#EM_FMax", _maxFreq];

// calculate the span for selected band graphics 
// 0.5/10 of span 
private _span = (_maxFreq - _minFreq) *0.05;
missionNamespace setVariable ["#EM_SelMin", _minFreq];
missionNamespace setVariable ["#EM_SelMax", (_minFreq + _span)];
