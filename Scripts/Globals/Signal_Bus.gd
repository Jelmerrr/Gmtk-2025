extends Node

#Audio related signals
signal Play_SFX(SFX, _Starting_Time)
signal Stop_SFX(SFX)

#Player related signals
signal Update_Player_State(state: Utils.playerSurfaceState)
signal Force_State_Update()
