#include <sourcemod>
#include <sdkhooks>
#include <sdktools>
#include <cstrike>

public Plugin:myinfo =
{
	name = "HvH.gg Teleport Fix",
	author = "imi-tat0r",
	description = "Fixes the teleport bug on wingman maps",
	version = "1.0",
}

public OnPluginStart()
{
	HookEvent("player_connect_full", Event_PlayerConnectFull, EventHookMode_Pre);
}

public Action Event_PlayerConnectFull(Handle event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	if(!IsValidClient(client))
		return Plugin_Continue;
		
	// force respawn the player
	CS_RespawnPlayer(client);
		
	return Plugin_Continue;
}

bool IsValidClient(int client)
{
    if (!(1 <= client <= MaxClients) || !IsClientInGame(client) || IsClientSourceTV(client) || IsClientReplay(client))
        return false;

    return true;
}