//
// Progress on the Path - TW3 Progress Tracker
// Script Version: 1.0.0 by K1ngTr4cker
//
//---------------------------------------------------
//-- Functions --------------------------------------
//---------------------------------------------------

function PotP_IsUsingNextGen() : bool 
{
	return !StrStartsWith(theGame.GetApplicationVersion(), "v 3");
}

//---------------------------------------------------
//-- Functions --------------------------------------
//---------------------------------------------------

function GetPotP(out master: CProgressOnThePath, optional caller: string): bool 
{
	PotP_Logger("GetPotP Called by [" + caller + "]");
	master = (CProgressOnThePath)SUTB_getModByTag('CProgressOnThePath_BootStrapper');
	
	return (bool) master;
}

//---------------------------------------------------
//-- Functions --------------------------------------
//---------------------------------------------------

function GetPotP_QuestGoblin(optional caller: string): CProgressOnThePath_QuestGoblin 
{
	var master: CProgressOnThePath;
	
	if (!GetPotP(master, caller)) 
	{ 
		return NULL; 
	}
	
	return master.PotP_QuestGoblin;
}

//---------------------------------------------------
//-- Functions --------------------------------------
//---------------------------------------------------

function PotP_IsPlayerBusy(): bool 
{
	if (PotP_PlayerIsMeditating()) 
	{
		return false;
	}
	
	return thePlayer.IsInNonGameplayCutscene()
		|| theGame.IsLoadingScreenVideoPlaying()
		|| thePlayer.IsInGameplayScene()
		|| !thePlayer.IsActionAllowed(EIAB_DrawWeapon)
		|| thePlayer.IsCiri()
		|| theGame.IsDialogOrCutscenePlaying()
		|| theGame.IsCurrentlyPlayingNonGameplayScene()
		|| theGame.IsFading()
		|| theGame.IsBlackscreen()
		|| thePlayer.IsInFistFightMiniGame()
		|| thePlayer.IsInCombat()
		|| !thePlayer.IsAlive();
}

//---------------------------------------------------
//-- Functions --------------------------------------
//---------------------------------------------------

function PotP_PlayerIsMeditating() : bool 
{
	return thePlayer.GetCurrentStateName() == 'Meditation' || thePlayer.GetCurrentStateName() == 'W3EEMeditation';
}

//---------------------------------------------------
//-- Functions --------------------------------------
//---------------------------------------------------

function PotP_Logger(message: string, optional ShowInGUI: bool, optional filename: name) 
{	
	if (filename == '') 
	{
		filename = 'PotP';
	}
	
	LogChannel(filename, message);
  
	if (ShowInGUI)
	{
		GetWitcherPlayer().DisplayHudMessage(NameToString(filename) + ": " + message);
	}
}

//---------------------------------------------------
//-- End Of Code ------------------------------------
//---------------------------------------------------