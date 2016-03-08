#define addf(fname) class fname {headerType = -1;}

class tcb {
	tag = "tcb";
	class Common_Net {
		file = "core\func\net";
		addf(netaddevent);
		addf(netaddeventcts);
		addf(netaddeventsto);
		addf(netaddeventtoclients);
		addf(netremoveevent);
		addf(netremoveeventcts);
		addf(netremoveeventsto);
		addf(netremoveeventservtoclients);
		addf(netrunevent);
		addf(netruneventcts);
		addf(netruneventsto);
		addf(netruneventtoclients);
		addf(netcallevent);
		addf(netcalleventcts);
		addf(netcalleventsto);
		addf(netcalleventtoclients);
		addf(netsetjip);
		addf(localcallevent);
	};
	class common {
		file = "core\func\common";
		addf(arrayPushStack);
		addf(arrayPushStack2);
		addf(randomFloor);
		addf(randomIndexArray);
		addf(countedIndexArray);
		addf(randomFloorArray);
		addf(randomArrayVal);
		addf(randomCeil);
		addf(playersNumber);
		addf(getDisplayName);
		addf(createMarkerGlobal);
		addf(createMarkerLocal);
		addf(createTrigger);
		addf(returnConfigEntry);
		addf(returnVehicleTurret);
		addf(checkMTShotHD);
	};
	class client {
		file = "core\func\client";
		addf(vehicleChat);
		addf(HQchat);
		addf(sidechat);
		addf(globalchat);
		addf(playerRespawn);
		addf(addperframe);
		addf(perframe);
		addf(removeperframe);
		addf(eject);
		addf(boardingCheckCrew);
		addf(checkGroupPower);
		addf(MarkerPlayers);
		addf(screen);
		addf(earPlugs);
		addf(nameTags);
		addf(spectating);
		addf(unFlip);
		addf(flipCheck);
		addf(jukeBox);
	};
	class ai_handling {
		file = "core\modules\ai_handling\fn";
		addf(ai_creategroup);
		addf(ai_followingTask);
		addf(ai_getUnitList);
		addf(ai_getMixedListe);
		addf(ai_grmakesearch);
		addf(ai_handleDeadVec);
		addf(ai_makeMechanics);
		addf(ai_makemgroup);
		addf(ai_makepatrolwpx);
		addf(ai_makevgroup);
		addf(ai_nearestBuilding);
		addf(ai_returnConfigEntry);
		addf(ai_returnVehicleTurrets);
		addf(ai_searchNearby);
		addf(ai_selectCrew);
		addf(ai_setState);
		addf(ai_setUnitCode);
		addf(ai_spawnCrew);
		addf(ai_spawnvehicle);
		addf(ai_taskDefend);
		addf(ai_getconfiggroup);
		addf(ai_GetRanPointCircle);
		addf(ai_GetRanPointCircleOuter);
		addf(ai_GetRanPointSquare);
		addf(ai_DirToObj);
		addf(ai_worldboundcheck);
		addf(ai_MPCheck);
		addf(ai_attackwp);
		addf(ai_setSkill);
		addf(ai_handleDamage);
		addf(ai_HCorServer);
		addf(ai_opc);
		addf(ai_opd);
	};
	
	class tcb_preinit {
		file = "core\script";
		class preinit {
			preInit = 1;
			headerType = -1;
		};
	};
	
};

class TAW_VD {
	tag = "TAWVD";
	class Initialize {
		file = "core\modules\taw_vd";
		addf(onSliderChanged);
		addf(onTerrainChanged);
		addf(updateViewDistance);
		addf(openMenu);
		addf(onChar);
		addf(openSaveManager);
		addf(onSavePressed);
		addf(onSaveSelectionChanged);
	};
};