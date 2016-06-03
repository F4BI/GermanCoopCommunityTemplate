class RscTitles {

	// From AIS injury by Pyschobastard (http://www.armaholic.com/page.php?id=24088)
	class ais_ProgressBar {
		idd = -1;
		movingEnable = 0;
		objects[] = {};
		duration = 1e+011;
		name = "ais_ProgressBar";
		onload = "_this call tcb_fnc_rev_progressBarInit;";

		class controlsBackground {
			class mpsf_progressbar_background {
				idc = 0;
				x = "0.298906 * safezoneW + safezoneX";
				y = "0.082 * safezoneH + safezoneY";
				w = "0.407344 * safezoneW";
				h = "0.011 * safezoneH";
				type = 0;
				style = 0;
				shadow = 0;
				colorShadow[] = {0,0,0,0.5};
				font = "PuristaMedium";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
				text = "";
				colorText[] = {1,1,1,1};
				colorBackground[] = {0,0,0,0.7};
				linespacing = 1;
			};
		};
		class controls {
			class mpsf_progressbar_foreground {
				idc = 1;
				x = "0.298906 * safezoneW + safezoneX";
				y = "0.082 * safezoneH + safezoneY";
				w = "0.001 * safezoneW";
				h = "0.011 * safezoneH";
				type = 0;
				style = 0;
				shadow = 0;
				colorShadow[] = {0,0,0,0.5};
				font = "PuristaMedium";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
				text = "";
				colorText[] = {1,1,1,1};
				colorBackground[] = {0.6784, 0.7490, 0.5137, 0.7};
				linespacing = 1;
			};
			class mpsf_progressbar_text {
				idc = 2;
				type = 13;
				style = 0x00;
				colorBackground[] = {0,0,0,0};
				x = "0.298906 * safezoneW + safezoneX";
				y = "0.093 * safezoneH + safezoneY";
				w = "0.407344 * safezoneW";
				h = "0.022 * safezoneH";	
				text = "";
				size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
				colorText[] = {0, 0, 0, 1};
				class Attributes {
					font = "EtelkaMonospaceProBold";
					color = "#FFFFFF";
					align = "left";
					valign = "middle";
					shadow = 1;
					shadowColor = "#000000";
					//size = "2.25";
				};
			};
		};
	};
	
	class have_fun {
	  	idd=-1;
		movingEnable = 0;
		fadein = 2;
		fadeout = 4;
		duration = 4;
	  	name="have_fun";
	  	controls[] = {Titelt1};
		class Titelt1 : RscStdText {
			font=DEFAULTFONT;
			text = "Have Fun!";
			colorText[] = Color_White;
			sizeEx = TextSize_medium;
			x = 0;
			y = 0.48;
			w = 1;
			h = 1;
		};
	};
	class geco_Label {
		idd = -1;
		movingEnable = 0;
		fadein = 2;
		fadeout = 4;
		duration = 4;
		name = "geco_Label";
		sizeEx = 256;
		class controls {
			class Picture : RscPicture {
				x = "SafeZoneX + SafeZoneW - 1.31";
				y = "SafeZoneY + SafeZoneH - 0.68";
				w = 0.20; h = 0.24;
				colorText[] = {1,1,1,0.6};
				text="core\img\geco_logo.paa";
				sizeEx = 256;
			};
		};
	};

	
	class dom_Empty {
		idd = -1;
		duration = 0;
		class controls {};
	};

	class FrameHandlerRsc {
		idd = -1;
		movingEnable = 1;
		enableSimulation = 1;
		enableDisplay = 1;
		duration = 1e+011;
		fadein  = 0;
		fadeout = 0;
		name = "FrameHandlerRsc";
		class controlsBackground {
			class dummy_map : Dummy_Map {
				x = -1;y = -1;w = 0;h = 0;
				onDraw = "call tcb_fnc_perFrame";
			};
		};
		class objects {};
		class controls {};
	};
	
	class only_pilots {
	  	idd=-1;
	  	movingEnable=0;
	  	duration=12;
	  	fadein=2;
	  	name="only_pilots";
	  	controls[] = {Titel};
		class Titel : RscStdText {
			text = "Only pilots are allowed to fly";
			colorText[] = Color_GrayLight;
			sizeEx = TextSize_medium;
			x = -0.8;
			y = -0.75;
			w = 1;
			h = 1;
		};
	};
	class only_crew {
	  	idd=-1;
	  	movingEnable=0;
	  	duration=12;
	  	fadein=2;
	  	name="only_crew";
	  	controls[] = {Titel};
		class Titel : RscStdText {
			text = "Only a crewman can use this position";
			colorText[] = Color_GrayLight;
			sizeEx = TextSize_medium;
			x = -0.8;
			y = -0.75;
			w = 1;
			h = 1;
		};
	};
	
	class RscDeadQuote {
		onload = "uinamespace setvariable ['tcb_title',_this select 0];";
		idd = 1792;
		movingEnable = false;
		moving = false;
		duration=10e10;
		enableSimulation = true;
		controlsBackground[] = {};
		objects[] = {};
		controls[] = {QuoteStructuredText, HeaderDeath};

		class HeaderDeath {
			idc = -1;
			type = CT_STRUCTURED_TEXT;
			style = ST_LEFT;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 0.0, 0.0, 1};
			x = safezoneX + 0.3 * safezoneW;
			y = safezoneY + 0.045 * safezoneW;
			w = 1;
			h = 0.6;
			size = 0.08;
			text = "You are dead.";
			class Attributes {
				font = DEFAULTFONT;
				color = "#CC0000";	// red
				align = "center";
				valign = "middle";
				shadow = false;
				shadowColor = "#ff0000";
				size = "1.6";
			};
		};

		class QuoteStructuredText {
			idc = 1793;
			type = CT_STRUCTURED_TEXT;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = {1,1,1,1};
			//x = 0.1;
			//y = 1.4;
			//x = "SafeZoneX + SafeZoneW - 1.9";
			//y = "SafeZoneY + SafeZoneH - 0.19";
			x = safezoneX + 0.3 * safezoneW;
			y = safezoneY + 0.67 * safezoneW;
			w = 1;
			h = 0.6;
			size = 0.02;
			text = "";
			class Attributes {
				font = DEFAULTFONT;
				color = "#000000";
				align = "center";
				valign = "middle";
				shadow = false;
				shadowColor = "#ff0000";
				size = "1.6";
			};
		};
	};
	
};