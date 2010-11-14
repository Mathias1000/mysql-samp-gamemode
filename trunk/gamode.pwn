#include <F_Streamer>
#include <a_samp>
#include <mysql>
#include <sscanf2>
#define MAX_STRING         128
#define MAX_QUERY         512
#define MAX_RESULT         1024
#define player_RegLog_DialogID 1
#include <MapIconStreamer>
#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#include <time>

#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_RED 0xFFFFFFAA
#define MAX_BLITZER 15 // Maximale Anzahl von Blitzern
#define BLITZER_TIMER_INTERVALL 500 // Intervall fÃ¼r das Blitzen (in Milliesekunden)
#define BLITZER_PAUSE 2 // Anzahl der Minuten, in denen der Spieler nicht mehr geblitzt werden kann

#define DB_HOST "127.0.0.1"
#define DB_NAME "gta"
#define DB_USER "root"
#define DB_PW   ""
#define paydaymondey 1001
//forward Loadobject();
//forward Loadvehicles();
//forward Loadplayerclass();
//forward payday();
#define DIALOG_LOGIN 1
#define DIALOG_Register 2
#define Logintext "Willkommen"
#define Login_Button1 "Login"
#define Login_Button2 "Abrechen"
#define Logintitle "Login"
#define List 3
#define regtext "Willkommen"
#define reg_Button1 "Register"
#define reg_Button2 "Abrechen"
#define regtitle "REGESTRATION"
//new Text:SPEEDOS[MAX_PLAYERS];

//fowards
forward Worldtime(playerid);
forward timebancheck(playerid);

enum Ammo
{
ammo1,
ammo2,
ammo3,
ammo4,
ammo5,
ammo6,
ammo7,
ammo8,
ammo9,
ammo10,
ammo11,
ammo12,
ammo13
}
enum Weapons
{
waffe1,
waffe2,
waffe3,
waffe4,
waffe5,
waffe6,
waffe7,
waffe8,
waffe9,
waffe10,
waffe11,
waffe12,
waffe13
}
enum eBlitzer {
	ID, Float:BlitzerX,
 Float:BlitzerY,
 Float:BlitzerZ,
 Radius,
 Geschwindigkeit,
 Erstellt
};
enum ms {
	IconID,
	Float:X,
	Float:Y,
	Float:Z,
	Markertype,
	Color,
	Float:Distance,
	bool:Created
}
enum ergebnisse
{
Playerexis,
Loginergebnis
}
enum pInfo
{
idplayer,
Logged,
Team,
Autoschein,
Flugschein,
Lastwagenschein,
Bootschein,
Motorradschein,
pPass[MAX_STRING],
bool:pIsLogin,
IP,
pKills,
AdminLevel,
pDeaths,
playerskin,
pCash,
};
enum counters
{
Logincounter
}
new ergebniss[MAX_PLAYERS][ergebnisse];
//new result[MAX_RESULT];
new Counters[MAX_PLAYERS][counters];
new Blitzer[MAX_BLITZER][eBlitzer];
new PlayerInfo[MAX_PLAYERS][pInfo];
new Pweapons[MAX_PLAYERS][Weapons];
new Pammo[MAX_PLAYERS][Ammo];
// results
new objectresult[MAX_RESULT];
new playerresult[MAX_RESULT];
new vehiclesresult[MAX_RESULT];
new Blizterresult[MAX_RESULT];
new playerclassresul[MAX_RESULT];
//query varis
//new query[MAX_QUERY];
new objectsql[MAX_QUERY];
new playersql[MAX_QUERY];
new vehiclessql[MAX_QUERY];
new Bliztersql[MAX_QUERY];
new playerclasssql[MAX_QUERY];
new saveweapons[MAX_QUERY];
new registersql[MAX_QUERY];
new checkpasswordsql[MAX_QUERY];
new saveplayer1[MAX_QUERY];
new insertvihcles[MAX_QUERY];
new checkplayersql[MAX_QUERY];
new teleportcoords[MAX_QUERY];
new delloc[MAX_QUERY];
new Selectban[MAX_QUERY];
new addloc[MAX_QUERY];
//max strings
new Updateplayer[MAX_STRING];
new Updateweapons[MAX_STRING];
new playerlogged[MAX_STRING];
new playerloggedsrc[MAX_STRING];
//another
new Menu:Navimenu;
new Area_tele[64];
new Text:Time, Text:Date;
new gPlayerName[MAX_PLAYERS][MAX_PLAYER_NAME],gPlayerIP[MAX_PLAYERS][16];

main()
{
print("\n----------------------------------");
print(" Blank Gamemode by your name here");
print("----------------------------------\n");
}
public OnFilterScriptExit()
{
	for(new objectid; objectid<F_MAX_OBJECTS; objectid++)
	{
	    F_DestroyObject(objectid);
	}
	F_ObjectUpdate(false);
	return 1;
}

public OnGameModeInit()
{
Navimenu = CreateMenu("Navi Menu", 1, 150.0, 150.0, 150.0, 150.0);
AddMenuItem(Navimenu, 0, "Arbeistamt");
/*AddMenuItem(teleportmenu, 0, "LS");
AddMenuItem(teleportmenu, 0, "SF");
AddMenuItem(teleportmenu, 0, "SF");
AddMenuItem(teleportmenu, 0, "LV");
AddMenuItem(teleportmenu, 0, "LV");
*/
/*AddMenuItem(teleportmenu, 1, "Grove Street");
AddMenuItem(teleportmenu, 1, "Starfish Tower");
AddMenuItem(teleportmenu, 1, "Wheel Arch Angels");
AddMenuItem(teleportmenu, 1, "Jizzys");
AddMenuItem(teleportmenu, 1, "4 Dragons");
AddMenuItem(teleportmenu, 1, "Come-a-Lot");*/
ConnectNPC("Zivi","Zivi");
DisableAllStreamedMapIcons();
SetGameModeText("Blank Script");
UsePlayerPedAnims();
//SetNameTagDrawDistance(40.0);
EnableStuntBonusForAll(0);
DisableInteriorEnterExits();
SetTimer("payday",100000,1);
//SetTimer("Speedometer", 100, true);
new MySQL:connection = mysql_init(LOG_ALL, 0);
mysql_connect(DB_HOST,DB_USER, DB_PW, DB_NAME,connection);
CreateObject(4550, 158.06913757324, -1667.8994140625, 85.795448303223, 0, 0, 0);
CreateObject(4550, 158.068359375, -1667.8994140625, 240.79544067383, 0, 0, 0);
CreateObject(4726, 158.2546081543, -1668.4096679688, 450.89190673828, 0, 0, 0);
CreateObject(4727, 158.34448242188, -1668.3406982422, 451.20001220703, 0, 0, 0);
CreateObject(1522, 185.7370300293, -1653.1131591797, 13.800000190735, 0, 0, 316);
CreateObject(1522, 184.38652038574, -1651.814453125, 13.800000190735, 0, 0, 315.99975585938);
CreateObject(3472, 189.21377563477, -1649.3099365234, 10, 0, 0, 45);
CreateObject(3461, 186.18280029297, -1649.4368896484, 15.527841567993, 0, 0, 0);
CreateObject(16777, 139.19212341309, -1586.6423339844, 10.39999961853, 0, 0, 97);
CreateObject(3406, 183.74325561523, -1656.2143554688, 11.800000190735, 0, 0, 225);
CreateObject(3406, 190.30841064453, -1649.7514648438, 11.800000190735, 0, 0, 45);
CreateObject(3406, 182.24008178711, -1654.8790283203, 11.800000190735, 0, 0, 225);
CreateObject(3406, 188.81413269043, -1648.2174072266, 11.800000190735, 0, 0, 44.994506835938);
CreateObject(3461, 189.11180114746, -1652.3619384766, 15.527841567993, 0, 0, 0);
CreateObject(3461, 192.21974182129, -1649.2713623047, 15.527841567993, 0, 0, 0);
CreateObject(3461, 189.30975341797, -1646.3311767578, 15.527841567993, 0, 0, 0);
CreateObject(8040, 203.9587097168, -1790.9768066406, 4.5, 0, 0, 180);
CreateObject(4639, 165.79641723633, -1782.6892089844, 5.4309549331665, 0, 0, 0);
CreateObject(4642, 165.05046081543, -1798.1539306641, 5.4385824203491, 0, 0, 90);
CreateObject(4642, 165.04483032227, -1794.5786132813, 5.4385824203491, 0, 0, 90);
CreateObject(4639, 165.76571655273, -1791.7824707031, 5.4385824203491, 0, 0, 0);
CreateObject(1696, 161.72659301758, -1786.1143798828, 3.160001039505, 350, 0, 270);
CreateObject(1696, 161.72598266602, -1787.9339599609, 3.160001039505, 349.99694824219, 0, 270);
CreateObject(8841, 202.70848083496, -1791.0499267578, 6.6999998092651, 0, 0, 0);
CreateObject(15025, 160.76347351074, -1671.6300048828, 25, 0, 0, 0);
CreateObject(15029, 160.44967651367, -1671.3631591797, 30, 0, 0, 0);
CreateObject(15029, 160.44921875, -1671.3623046875, 25, 0, 0, 0);
CreateObject(15025, 160.7626953125, -1671.6298828125, 30, 0, 0, 0);
CreateObject(15029, 160.44921875, -1671.3623046875, 65, 0, 0, 0);
CreateObject(15029, 160.44921875, -1671.3623046875, 60, 0, 0, 0);
CreateObject(15029, 160.44921875, -1671.3623046875, 55, 0, 0, 0);
CreateObject(15029, 160.44921875, -1671.3623046875, 50, 0, 0, 0);
CreateObject(15029, 160.44921875, -1671.3623046875, 45, 0, 0, 0);
CreateObject(15029, 160.44921875, -1671.3623046875, 40, 0, 0, 0);
CreateObject(15029, 160.44921875, -1671.3623046875, 35, 0, 0, 0);
CreateObject(15025, 160.7626953125, -1671.6298828125, 60, 0, 0, 0);
CreateObject(15025, 160.7626953125, -1671.6298828125, 55, 0, 0, 0);
CreateObject(15025, 160.7626953125, -1671.6298828125, 50, 0, 0, 0);
CreateObject(15025, 160.7626953125, -1671.6298828125, 45, 0, 0, 0);
CreateObject(15025, 160.7626953125, -1671.6298828125, 40, 0, 0, 0);
CreateObject(15025, 160.7626953125, -1671.6298828125, 35, 0, 0, 0);
CreateObject(15025, 160.7626953125, -1671.6298828125, 65, 0, 0, 0);
CreateObject(3089, 154.82661437988, -1670.4754638672, 59.5, 0, 0, 90);
CreateObject(3089, 154.826171875, -1670.474609375, 64.5, 0, 0, 90);
CreateObject(3089, 154.826171875, -1670.474609375, 29.5, 0, 0, 90);
CreateObject(3089, 154.826171875, -1670.474609375, 34.5, 0, 0, 90);
CreateObject(3089, 154.826171875, -1670.474609375, 39.5, 0, 0, 90);
CreateObject(3089, 154.826171875, -1670.474609375, 44.5, 0, 0, 90);
CreateObject(3089, 154.826171875, -1670.474609375, 49.5, 0, 0, 90);
CreateObject(3089, 154.826171875, -1670.474609375, 54.5, 0, 0, 90);
CreateObject(3089, 154.826171875, -1670.474609375, 24.5, 0, 0, 90);
CreateObject(14595, 174.41102600098, -1675.8975830078, -1.0901985168457, 0, 0, 0);
CreateObject(3089, 173.64363098145, -1662.7166748047, -3.7143211364746, 0, 0, 0);
CreateObject(3089, 163.08688354492, -1680.8228759766, -3.7143211364746, 0, 0, 0);
CreateObject(3089, 149.30368041992, -1680.9982910156, -3.8995428085327, 0, 0, 0);
CreateObject(2605, 180.01472473145, -1678.9389648438, -4.6448860168457, 0, 0, 90);
CreateObject(2607, 180.57627868652, -1677.5146484375, -4.6476392745972, 0, 0, 180);
CreateObject(2605, 182.5361328125, -1677.5439453125, -4.6448860168457, 0, 0, 0);
CreateObject(2356, 181.02500915527, -1678.7631835938, -5.0433235168457, 0, 0, 120);
CreateObject(2356, 182.71200561523, -1678.4752197266, -5.0433235168457, 0, 0, 30);
CreateObject(2309, 182.77085876465, -1676.2154541016, -5.0433235168457, 0, 0, 180);
CreateObject(2309, 182.12454223633, -1676.2316894531, -5.0433235168457, 0, 0, 179.99450683594);
CreateObject(2309, 178.77137756348, -1679.2272949219, -5.0433235168457, 0, 0, 270);
CreateObject(2309, 178.8088684082, -1678.5124511719, -5.0433235168457, 0, 0, 270);
CreateObject(1724, 176.85807800293, -1669.4525146484, -5.0433235168457, 0, 0, 270);
CreateObject(1724, 176.85795593262, -1668.2744140625, -5.0433235168457, 0, 0, 270);
CreateObject(1724, 176.84873962402, -1667.09765625, -5.0433235168457, 0, 0, 270);
CreateObject(1724, 176.84664916992, -1665.9449462891, -5.0433235168457, 0, 0, 270);
CreateObject(5422, 177.47311401367, -1688.0194091797, -3.0309562683105, 0, 0, 0);
Loadobject();
Loadvehicles();
Loadplayerclass();
LoadBlizter();
SetTimer("settime",1000,true);
Date = TextDrawCreate(547.000000,11.000000,"--");
TextDrawFont(Date,3);
TextDrawLetterSize(Date,0.399999,1.600000);
TextDrawColor(Date,0xffffffff);
Time = TextDrawCreate(547.000000,28.000000,"--");
TextDrawFont(Time,3);
TextDrawLetterSize(Time,0.399999,1.600000);
TextDrawColor(Time,0xffffffff);
SetTimer("Worldtime",1000,true);
return 1;
}

forward TimeUpdate();
new worldTime;

public TimeUpdate() {
    worldTime++;
    worldTime%=24;
    SetWorldTime(worldTime);
}
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_YELLOW2 0xF5DEB3AA
public OnGameModeExit()
{
mysql_close();
return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
if(PlayerInfo[playerid][playerskin] == 0)
{
SetPlayerPos(playerid,839.1575,-2061.9944,12.8679);
SetPlayerFacingAngle(playerid, 91.3850);
SetPlayerCameraPos(playerid,837.5432,-2061.9944,12.8672);
SetPlayerCameraLookAt(playerid,837.5432,-2061.9944,12.8672);
return 1;
}
else
{
SetSpawnInfo(playerid,0,0,839.1575,-2061.9944,12.8679,91.3850,0,0,0,0,0,0);
SetPlayerSkin(playerid, PlayerInfo[playerid][playerskin]);
SetPlayerPos(playerid,839.1575,-2061.9944,12.8679);
SetPlayerTeam(playerid, PlayerInfo[playerid][Team]);
SpawnPlayer(playerid);
}
return 1;
}
stock Tutrial() {
for (new i = 0; i < MAX_PLAYERS; i++) {
SendClientMessage(i,0xFFFF00FF,"Payday! Du Erhalst §%d!",paydaymondey);
GivePlayerMoney(i,paydaymondey);
}
return 1;
}
stock payday() {
for (new i = 0; i < MAX_PLAYERS; i++) {
SendClientMessage(i,0xFFFF00FF,"Payday! Du Erhalst §%d!",paydaymondey);
GivePlayerMoney(i,paydaymondey);
}
return 1;
}
public OnPlayerConnect(playerid)
{
GetPlayerName(playerid, gPlayerName[playerid], MAX_PLAYER_NAME);
GetPlayerIp(playerid,gPlayerIP[playerid],16);
timebancheck(playerid);
F_Streamer_OnPlayerConnect(playerid);
MySQL_Player_Exist(playerid);
if(ergebniss[playerid][Playerexis]==1)
{
ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_INPUT,Logintitle,Logintext,Login_Button1,Login_Button2);
}
else
{
ShowPlayerDialog(playerid,DIALOG_Register,DIALOG_STYLE_INPUT,regtitle,regtext,reg_Button1,reg_Button2);
}
if(IsPlayerNPC(playerid))
{
new botname[MAX_PLAYER_NAME];
GetPlayerName(playerid, botname, sizeof(botname));
if(!strcmp(botname, "Zivi", true))
{
                                 PlayerInfo[playerid][Logged]=1;//Der Bot ist gleich eingeloggt (Anpassen!)
}
}
return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
TextDrawHideForPlayer(playerid, Time), TextDrawHideForPlayer(playerid, Date);
savewaepons(playerid);
MySQL_Player_SAVE(playerid);
//accountLogged(playerid);
//Player_save_Data(playerid);
resetewapons(playerid);
resetvaris(playerid);
return 1;
}

public OnPlayerSpawn(playerid)
{
//timebancheck(playerid);
if(IsPlayerNPC(playerid))
{
new botname[MAX_PLAYER_NAME];
GetPlayerName(playerid, botname, sizeof(botname));
if(!strcmp(botname, "Zivi", true))
{
SetPlayerSkin(playerid,173);
                      //Hier den Bot sachen geben, wie Waffen oder Ähnliches
}
  }

new neu;
neu  = GetPlayerSkin(playerid);

printf("skin %i",neu);
givealldbweapons(playerid);
PlayerInfo[playerid][playerskin] = neu;
if(PlayerInfo[playerid][playerskin] == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"Dieser skin ist Verboten");
SetPlayerHealth(playerid,0);
}
TextDrawShowForPlayer(playerid, Time), TextDrawShowForPlayer(playerid, Date);
accountLogged(playerid);
return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{

PlayerInfo[killerid][pKills]++;
PlayerInfo[playerid][pDeaths]++;
return 1;
}
public OnVehicleSpawn(vehicleid)
{
return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
return 1;
}

public OnPlayerText(playerid, text[])
{
return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
//dcmd(kick,4,cmdtext);
dcmd(spawn,5,cmdtext);
dcmd(spawn_car,9,cmdtext);
dcmd(helptype,8,cmdtext);
dcmd(kartbahn,8,cmdtext);
dcmd(tele,4,cmdtext);
dcmd(coords,6,cmdtext);
dcmd(teleport,8,cmdtext);
dcmd(teleadd,7,cmdtext);
dcmd(teledel,7,cmdtext);
dcmd(delc,4,cmdtext);
dcmd(addc,4,cmdtext);
dcmd(navi,4,cmdtext);
dcmd(timeban,7,cmdtext);
dcmd(unban,5,cmdtext);
return 0;
}


public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
return 1;
}
dcmd_spawn(playerid,params[]) {
new Float:x,Float:y,Float:z,Float:ang;
new color1,color2,model;
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
if(PlayerInfo[playerid][AdminLevel] > 1)
{
if(sscanf(params, "iii",color1,color2,model)) {
return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /spawn  color1 color2 model");
}
GetPlayerPos(playerid,Float:x,Float:y,Float:z);
GetPlayerFacingAngle(playerid,Float:ang);
CreateVehicle(model,x,y,z,ang,color1,color2,-1);
}
return 1;
}
dcmd_helptype(playerid,params[]) {
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
if(PlayerInfo[playerid][AdminLevel] > 1)
{
new helptypi;
if(sscanf(params, "i",helptypi)) {
return SendClientMessage(playerid,COLOR_WHITE,"Auto = 1 Boot = 2 Flugzeug = 3 Lastwagen = 4 Motorrad = 5");
}
}
return 1;
}
dcmd_navi(playerid,params[]){
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
//ShowPlayerDialog(playerid, List, DIALOG_STYLE_LIST, "Opciones", "Armas\nAutos", "Seleccionar", "Cancelar");
ShowMenuForPlayer(Navimenu,playerid);
SetTimer("Tutrial",10,1);
return 1;
}
dcmd_delc(playerid,params[]){
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
DisablePlayerCheckpoint(playerid);
return 1;
}
dcmd_addc(playerid,params[]){
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
SetPlayerCheckpoint(playerid, 1480.201049, -1770.545043, 18.795755, 3.0);
return 1;
}
dcmd_teleadd(playerid,params[]) {
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
if(PlayerInfo[playerid][AdminLevel] > 1)
{
new lvl;
new araname[64];
new Float:x,Float:y,Float:z,Float:ang;
if(sscanf(params, "s[64]i",araname,lvl)) {
return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /teleadd name adminlevel");
}
GetPlayerPos(playerid,Float:x,Float:y,Float:z);
GetPlayerFacingAngle(playerid,Float:ang);
format(addloc,sizeof(addloc), "INSERT INTO `teleport_coords` ( pos_x,pos_y,pos_z,pos_r,AreaName,AdminLevel) VALUES ('%f','%f','%f','%f','%s','%i')",x,y,z,ang,araname,lvl);
mysql_query(addloc);
SendClientMessage(playerid,COLOR_WHITE,"Erfolgreich Hinzugefügt");
mysql_free_result();
}
return 1;
}
dcmd_teleport(playerid,params[])
{
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
//if(PlayerInfo[playerid][AdminLevel] > 1)
//new Area_tele[64];
if(sscanf(params, "s[64]",Area_tele))  {
return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /teleport Locazion");
}
{
//return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /teleport Areaname");
new Float:pos_x_tele,Float:pos_y_tele,Float:pos_z_tele;
//new Float:pos_r_tele;
//new AdminLevel_tele;
format(teleportcoords,sizeof(teleportcoords),"SELECT * FROM `teleport_coords` WHERE `AreaName`= '%s' LIMIT 1;",Area_tele);
mysql_query(teleportcoords);
mysql_store_result();
if(mysql_num_rows() == 1)
{
mysql_fetch_field("pos_x",teleportcoords); pos_x_tele = floatstr(teleportcoords);
mysql_fetch_field("pos_y",teleportcoords); pos_y_tele = floatstr(teleportcoords);
mysql_fetch_field("pos_z",teleportcoords); pos_z_tele = floatstr(teleportcoords);
//mysql_fetch_field("pos_r",teleportcoords); pos_r_tele = floatstr(teleportcoords);
//mysql_fetch_field("AdminLevel",teleportcoords); AdminLevel_tele = strval(teleportcoords);
//mysql_fetch_field("AreaName",teleportcoords); AreaName_tele = strval(teleportcoords);
}
SetPlayerPos(playerid,pos_x_tele,pos_y_tele,pos_z_tele);
/*if(AdminLevel_tele < PlayerInfo[playerid][AdminLevel])
{
SetPlayerPos(playerid,pos_x_tele,pos_y_tele,pos_z_tele);
return 1;
}
if(mysql_num_rows() == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"teleport Areanem not found");
}*/
mysql_free_result();
return 1;
}
}
dcmd_teledel(playerid,params[]) {
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
if(PlayerInfo[playerid][AdminLevel] > 1)
{
new araname[64];
if(sscanf(params, "s[64]",araname)) {
return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /teleadel name ");
}
format(delloc,sizeof(delloc), "DELETE FROM teleport_coords WHERE `AreaName`= '%s'",araname);
mysql_query(delloc);
if(mysql_num_rows() == 1)
{

SendClientMessage(playerid,COLOR_WHITE,"teleport Locazion Erfolgreich Gelöscht");
return 1;
}
else
{
SendClientMessage(playerid,COLOR_WHITE,"Löschung Fehlgeschlagen");
mysql_free_result();
return 1;
}
}
return 1;
}

/*
	Resume Command
	Usage: /resume
	Description: Used to resume a paused round.
	Access: Administrators
*/
dcmd_spawn_car(playerid,params[]) {
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
if(PlayerInfo[playerid][AdminLevel] > 1)
{
new Float:x,Float:y,Float:z,Float:ang;
new type,color1,color2,model;
if(sscanf(params, "iiii",type,color1,color2,model)) {
return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /spawn_car type color1 color2 model");
}
GetPlayerPos(playerid,Float:x,Float:y,Float:z);
GetPlayerFacingAngle(playerid,Float:ang);
format(insertvihcles,sizeof(insertvihcles), "INSERT INTO `vehicles` (modelid, pos_x,pos_y,pos_z,pos_r,type,color1,color2) VALUES ('%i','%f','%f','%f','%f','%i','%i','%i')",model,x,y,z,ang,type,color1,color2);
mysql_query(insertvihcles);
CreateVehicle(model,x,y,z,ang,type,color1,color2);
printf(" %f %f %f %f %i %i %i %i",x,y,z,ang,type,color1,color2,model);
mysql_free_result();
}
return 1;
}
dcmd_coords(playerid,params[]) {
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
if(PlayerInfo[playerid][AdminLevel] > 1)
{
new comment[64];
new Float:x,Float:y,Float:z,Float:ang;
if(sscanf(params, "s[64]",comment)) {
return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /coords comment");
}
GetPlayerPos(playerid,Float:x,Float:y,Float:z);
GetPlayerFacingAngle(playerid,Float:ang);
format(insertvihcles,sizeof(insertvihcles), "INSERT INTO `coords` ( pos_x,pos_y,pos_z,pos_r,comments) VALUES ('%f','%f','%f','%f','%s')",x,y,z,ang,comment);
mysql_query(insertvihcles);
SendClientMessage(playerid,COLOR_WHITE,"command ausgefürt");
mysql_free_result();
}
return 1;
}
dcmd_tele(playerid, params[]){
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
//199.8784,-1644.7742,14.0000
#pragma unused params
SetPlayerPos(playerid,199.8784,-1644.7742,14.0000);
return 1;
}
dcmd_kartbahn(playerid, params[]) {
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
#pragma unused params
SetPlayerPos(playerid, -2043.3737, -115.5196, 35.2112);
return 1;
}
/*dcmd_unban(playerid,params[])
{
new query[MAX_QUERY];
new unbanname[MAX_PLAYER_NAME];
if(sscanf(params,"s[24]",unbanname)) return SendClientMessage(playerid,COLOR_YELLOW,"Benutzung. /unban [NAME]");
//	if(Spieler[playerid][pAdmin] < 1) return SendClientMessage(playerid,COLOR_RED,"Du bist kein Admin");
format(query,sizeof(query),"DELETE FROM timeban WHERE `Name`= '%s'",unbanname);
mysql_query(query);
return 1;
}*/

dcmd_timeban(playerid,params[])
{
	new pid,
	grund[128],dauer;
	if(sscanf(params,"uds[128]",pid,dauer,grund)) return SendClientMessage(playerid,COLOR_YELLOW,"Benutzung:/timeban [ID][Dauer][GRUND]");
//	if(Spieler[playerid][pAdmin] < 1) return SendClientMessage(playerid,COLOR_RED,"Du bist kein Admin");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid,COLOR_RED,"Kein Spieler mit der angegebenen ID ist Online");
	new string[128],
	string2[128];
	format(string,sizeof(string),"Du wurdest fÃ¼r %d Minuten vom Server gebannt Grund:%s",dauer,grund);
	format(string2,sizeof(string),"Du hast %s fÃ¼r %d Minuten vom Server gebannt",gPlayerName[pid],dauer);
	SendClientMessage(pid,COLOR_RED,string);
	SendClientMessage(playerid,COLOR_RED,string2);
	Kick(pid);
	new zeitdauer=Now()+dauer*60;
	timebanplayer(gPlayerName[pid],grund,gPlayerIP[pid],gPlayerName[playerid],zeitdauer);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
/*


format(selctsql,sizeof(selctsql),"SELECT type FROM `vehicles` WHERE `modelid`= '%s' LIMIT 1;",modelid);
mysql_query(selctsql); mysql_store_result();
if(mysql_fetch_row(resultline))
{
mysql_fetch_field("type",selctsql); type = strval(selctsql);
}
mysql_free_result();
{
if(type == 1 && Autoschein == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"Du hast keinen Autoschein");
RemovePlayerFromVehicle(playerid);
}
if(type == 2 && Bootschein == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"Du hast kein Bootschein");
RemovePlayerFromVehicle(playerid);
}
if(type == 3 && Flugschein == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"Du hast kein Flugschein");
RemovePlayerFromVehicle(playerid);
}
if(type == 4 && Lastwagenschein == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"Du hast kein Lastwagenschein");
RemovePlayerFromVehicle(playerid);
}
if(type == 5 && Motorradschein == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"Du hast kein Motorradschein");
RemovePlayerFromVehicle(playerid);
}
}*/
return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
DisablePlayerCheckpoint(playerid);
return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
return 1;
}

public OnRconCommand(cmd[])
{
return 1;
}


public OnPlayerRequestSpawn(playerid)
{
return 1;
}

public OnObjectMoved(objectid)
{
return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
new Menu:CurrentMenu = GetPlayerMenu(playerid);
if(CurrentMenu == Navimenu)
{
    switch(row)
    {
case 0: //Arbeistamt
{
SetPlayerCheckpoint(playerid, 1480.201049, -1770.545043, 18.795755, 3.0);
SendClientMessage(playerid, 0xFFFFFFFF, "Checkpoint Zum Arbeitsamt würde gesezt");
}
}
}
return 1;
}

public OnPlayerExitedMenu(playerid)
{
return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
return 1;
}

public OnPlayerUpdate(playerid)
{
return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
return 1;
}
/*new scheinsql[300],resultlinee[300], selctsql[280],resultline[300];
new type,Autoschein,Flugschein,Bootschein,Lastwagenschein,Motorradschein;
new vehicleid = GetPlayerVehicleID(playerid);
new modelid = GetVehicleModel(vehicleid);
format(scheinsql,sizeof(scheinsql),"SELECT Autoschein,Flugschein,Bootschein,Lastwagenschein,Motorradschein FROM `players` WHERE `Name`= '%s' LIMIT 1;",oGetPlayerName(playerid));
mysql_query(scheinsql); mysql_store_result();
if(mysql_fetch_row(resultlinee))
{
mysql_fetch_field("Autoschein",scheinsql); Autoschein = strval(scheinsql);
mysql_fetch_field("Flugschein",scheinsql); Flugschein = strval(scheinsql);
mysql_fetch_field("Bootschein",scheinsql); Bootschein = strval(scheinsql);
mysql_fetch_field("Lastwagenschein",scheinsql); Lastwagenschein = strval(scheinsql);
mysql_fetch_field("Motorradschein",scheinsql); Motorradschein = strval(scheinsql);
mysql_free_result();
}*/
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{

if(dialogid==DIALOG_LOGIN)
{
if(response==0)
{
SendClientMessage(playerid,COLOR_WHITE,"Vorgang Abgebrochen");
Kick(playerid);
return 1;
}
if(response==1)
{
if(!strlen(inputtext))
{
SendClientMessage(playerid,COLOR_WHITE,"Bitte Fülle Das Feld Aus");
Counters[playerid][Logincounter]++;
ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_INPUT,Logintitle,Logintext,Login_Button1,Login_Button2);
return 1;
}
else
{
if(Counters[playerid][Logincounter] == 3||Counters[playerid][Logincounter] > 3)
{
SendClientMessage(playerid,COLOR_WHITE,"Login Fehlgeschlagen");
Kick(playerid);
}
else
{
checkpassword(playerid,inputtext);
return 1;
}
}
}
}
if(dialogid==DIALOG_Register)
{
if(response==0)
{
SendClientMessage(playerid,COLOR_WHITE,"Vorgang Abgebrochen");
Kick(playerid);
return 1;
}
if(response==1)
{
if(!strlen(inputtext))
{
SendClientMessage(playerid,COLOR_WHITE,"Bitte Fülle Das Feld Aus");
ShowPlayerDialog(playerid,DIALOG_Register,DIALOG_STYLE_INPUT,regtitle,regtext,reg_Button1,reg_Button2);
return 1;
}
else
{
register_player(playerid,inputtext);
return 1;
}
}
}

return 1;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    return 1;
}
stock Loadobject()
{

new modelid;
new Float:pos_ox, Float:pos_oy, Float:pos_oz,Float:pos_rx, Float:pos_ry, Float:pos_rz,Float:distanz;

format(objectsql,sizeof(objectsql),"SELECT COUNT(*) FROM object");
mysql_query(objectsql);
mysql_store_result();
mysql_fetch_row(objectresult);
new SizeOfVeh = strval(objectresult);
for(new i = 0; i < SizeOfVeh; i++)
{

format(objectsql,sizeof(objectsql),"SELECT * FROM object LIMIT %d, 1", i);
mysql_query(objectsql); mysql_store_result();
if(mysql_fetch_row(objectresult))
{
mysql_fetch_field("modelid",objectsql); modelid = strval(objectsql);
mysql_fetch_field("pos_x",objectsql); pos_ox = floatstr(objectsql);
mysql_fetch_field("pos_y",objectsql); pos_oy = floatstr(objectsql);
mysql_fetch_field("pos_z",objectsql); pos_oz = floatstr(objectsql);
mysql_fetch_field("pos_rx",objectsql); pos_rx = floatstr(objectsql);
mysql_fetch_field("pos_ry",objectsql); pos_ry = floatstr(objectsql);
mysql_fetch_field("pos_rz",objectsql); pos_rz = floatstr(objectsql);
mysql_fetch_field("distanz",objectsql); distanz = floatstr(objectsql);
//mysql_free_result();
}
if (mysql_num_rows() > 0)
{
//CreateObject(modelid,pos_ox,pos_oy,pos_oz,pos_rx,pos_ry,pos_rz);
printf("object %d pos_x %f pos_y %f pos_z %f pos_rx %f pos_ry %f pos_rz distanz %f",modelid,pos_ox,pos_oy,pos_oz,pos_rx,pos_ry,pos_rz,distanz);
F_CreateObject(modelid, pos_ox, pos_oy, pos_oz, pos_rx, pos_ry, pos_rz,distanz);
}
}
mysql_free_result();
}
stock Loadvehicles()
{

new modelid;
new Float:pos_x, Float:pos_y, Float:pos_z, pos_r;

new color1,color2;
format(vehiclessql,sizeof(vehiclessql),"SELECT COUNT(*) FROM vehicles");
mysql_query(vehiclessql);
mysql_store_result();
mysql_fetch_row(vehiclesresult);
new SizeOfVeh = strval(vehiclesresult);
for(new i = 0; i < SizeOfVeh; i++)
{

format(vehiclessql,sizeof(vehiclessql),"SELECT * FROM vehicles LIMIT %d, 1", i);
mysql_query(vehiclessql); mysql_store_result();
if(mysql_fetch_row(vehiclesresult))
{
mysql_fetch_field("modelid",vehiclessql); modelid = strval(vehiclessql);
mysql_fetch_field("pos_x",vehiclessql); pos_x = floatstr(vehiclessql);
mysql_fetch_field("pos_y",vehiclessql); pos_y = floatstr(vehiclessql);
mysql_fetch_field("pos_z",vehiclessql); pos_z = floatstr(vehiclessql);
mysql_fetch_field("color1",vehiclessql); color1 = strval(vehiclessql);
mysql_fetch_field("color2",vehiclessql); color2 = strval(vehiclessql);

}
if (mysql_num_rows() > 0)
{
CreateVehicle(modelid,pos_x,pos_y,pos_z,pos_r,color1,color2, -1);
printf("creating vehicles  %d %f %f %f %f %d %d ",modelid,pos_x,pos_y,pos_z,pos_r,color1,color2);
//mysql_free_result();
}
}
}
stock LoadBlizter()
{
new radius;
new Float:pos_x, Float:pos_y, Float:pos_z, speed;

format(Bliztersql,sizeof(Bliztersql),"SELECT COUNT(*) FROM Blizter");
mysql_query(Bliztersql);
mysql_store_result();
mysql_fetch_row(Blizterresult);
new SizeOfVeh = strval(Blizterresult);
for(new i = 0; i < SizeOfVeh; i++)
{

format(Bliztersql,sizeof(Bliztersql),"SELECT * FROM Blizter LIMIT %d, 1", i);
mysql_query(Bliztersql); mysql_store_result();
if(mysql_fetch_row(Blizterresult))
{
//AddBlitzerxyz(x,y,z,speed,radius);
mysql_fetch_field("pos_x",Bliztersql); pos_x = floatstr(Bliztersql);
mysql_fetch_field("pos_y",Bliztersql); pos_y = floatstr(Bliztersql);
mysql_fetch_field("pos_z",Bliztersql); pos_z = floatstr(Bliztersql);
mysql_fetch_field("speed",Bliztersql); speed = strval(Bliztersql);
mysql_fetch_field("radius",Bliztersql); radius = strval(Bliztersql);

}
if (mysql_num_rows() > 0)
{
AddBlitzerxyz(pos_x,pos_y,pos_z,speed,radius);
printf("stelle blizter auf  %f %f %f %f %d %d ",pos_x,pos_y,pos_z,speed,radius);
}
//mysql_free_result();
}
}
stock Loadplayerclass()
{
new weapon1 , weapon1_ammo, weapon2, weapon2_ammo,weapon3, weapon3_ammo;
new Float:pos_x, Float:pos_y, Float:pos_z,Float:pos_r;


format(playerclasssql,sizeof(playerclasssql),"SELECT COUNT(*) FROM playerclass");
mysql_query(playerclasssql);
mysql_store_result();
mysql_fetch_row(playerclassresul);
new classskin;
new SizeOfVeh = strval(playerclassresul);
for(new i = 0; i < SizeOfVeh; i++)
{

format(playerclasssql,sizeof(playerclasssql),"SELECT * FROM playerclass LIMIT %d, 1", i);
mysql_query(playerclasssql); mysql_store_result();
if(mysql_fetch_row(playerclassresul))
{
mysql_fetch_field("skin",playerclasssql); classskin = strval(playerclasssql);
mysql_fetch_field("pos_x",playerclasssql); pos_x = floatstr(playerclasssql);
mysql_fetch_field("pos_y",playerclasssql); pos_y = floatstr(playerclasssql);
mysql_fetch_field("pos_z",playerclasssql); pos_z = floatstr(playerclasssql);
mysql_fetch_field("pos_r",playerclasssql); pos_r = floatstr(playerclasssql);
mysql_fetch_field("weapon1",playerclasssql); weapon1 = strval(playerclasssql);
mysql_fetch_field("weapon1_ammo",playerclasssql); weapon1_ammo = strval(playerclasssql);
mysql_fetch_field("weapon2",playerclasssql); weapon2 = strval(playerclasssql);
mysql_fetch_field("weapon2_ammo",playerclasssql); weapon2_ammo = strval(playerclasssql);
mysql_fetch_field("weapon3",playerclasssql); weapon3 = strval(playerclasssql);
mysql_fetch_field("weapon3_ammo",playerclasssql); weapon3_ammo = strval(playerclasssql);
}
if (mysql_num_rows() > 0)
{
AddPlayerClass(classskin, pos_x, pos_y, pos_z, pos_r,weapon1 , weapon1_ammo, weapon2, weapon2_ammo,weapon3, weapon3_ammo);
printf("added playerclass %d %f %f %f %f %d %d %d %d %d %d",classskin, pos_x, pos_y, pos_z, pos_r,weapon1 , weapon1_ammo, weapon2, weapon2_ammo,weapon3, weapon3_ammo);
}
}
return 1;
}
stock MySQL_Player_Exist(playerid)
{
format(checkplayersql,sizeof(checkplayersql), "SELECT * FROM `players` WHERE `Name` = '%s'", oGetPlayerName(playerid));
mysql_query(checkplayersql);
mysql_store_result();
if(mysql_num_rows() == 1)
{
ergebniss[playerid][Playerexis] = 1;
return 1;
}
else
{
ergebniss[playerid][Playerexis] = 0;
return 1;
}
}

stock MySQL_Player_SAVE(playerid)
{
if(PlayerInfo[playerid][pIsLogin] == false) return 1;

format(saveplayer1,sizeof(saveplayer1),"UPDATE `players` SET ");
format(Updateplayer,sizeof(Updateplayer),"`Money`=%d,",PlayerInfo[playerid][pCash]);
strcat(saveplayer1,Updateplayer,sizeof(saveplayer1));
format(Updateplayer,sizeof(Updateplayer),"`Kills`=%d,",PlayerInfo[playerid][pKills]);
strcat(saveplayer1,Updateplayer,sizeof(saveplayer1));
format(Updateplayer,sizeof(Updateplayer),"`Deaths`=%d,",PlayerInfo[playerid][pDeaths]);
strcat(saveplayer1,Updateplayer,sizeof(saveplayer1));
format(Updateplayer,sizeof(Updateplayer),"`Logged`=0,");
strcat(saveplayer1,Updateplayer,sizeof(saveplayer1));
format(Updateplayer,sizeof(Updateplayer),"`playerid`=0,");
strcat(saveplayer1,Updateplayer,sizeof(saveplayer1));
format(Updateplayer,sizeof(Updateplayer),"`skin`=%d,",PlayerInfo[playerid][playerskin]);
strcat(saveplayer1,Updateplayer,sizeof(saveplayer1));
format(Updateplayer,sizeof(Updateplayer),"`Team`=%d",PlayerInfo[playerid][Team]);
strcat(saveplayer1,Updateplayer,sizeof(saveplayer1));
format(Updateplayer,sizeof(Updateplayer)," WHERE `Name`='%s'",oGetPlayerName(playerid));
strcat(saveplayer1,Updateplayer,sizeof(saveplayer1));
mysql_query(saveplayer1);
mysql_free_result();
return 1;
}

stock oGetPlayerName(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid,name,sizeof(name));
    return name;
}
stock oSetPlayerMoney(playerid, money)
{
    PlayerInfo[playerid][pCash] = money;
    ResetPlayerMoney(playerid);
    return GivePlayerMoney(playerid,money);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CallBacks
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
forward Blitzer_Timer();
public Blitzer_Timer() {
    new save, strafe, speed;
 	for (new playerid = 0; playerid < MAX_PLAYERS; playerid++)
  {
 	    save = GetPVarInt(playerid, "BlitzPause");
		if(save > 0)
   {
			save--;
			SetPVarInt(playerid, "BlitzPause", save);
			continue;
		}
 		if(!IsPlayerInAnyVehicle(playerid) || IsPlayerNPC(playerid)) continue;
		for(new i = 0; i < sizeof(Blitzer); i++) {
			if(Blitzer[i][Erstellt] == 1) {
			    if(IsPlayerInRangeOfPoint(playerid, Blitzer[i][Radius], Blitzer[i][BlitzerX], Blitzer[i][BlitzerY], Blitzer[i][BlitzerZ])) {
					speed = ErmittleGeschwindigkeit(playerid,true);
					if(speed > Blitzer[i][Geschwindigkeit]) {
						new string[128];
						// Einstellen des Momentes, in dem der Spieler kein weiteres mal geblitzt werden kann
						SetPVarInt(playerid, "BlitzPause", (BLITZER_TIMER_INTERVALL * BLITZER_PAUSE * 60) / 1000);
						// Strafe fÃ¼r Spieler
						strafe = (speed*2) - Blitzer[i][Geschwindigkeit];
						PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
					   	GivePlayerMoney(playerid, -strafe);
						// Text fÃ¼r Spieler
						SendClientMessage(playerid, 0xFF6347AA,"Du wurdest wegen zu hoher Geschwindigkeit geblitzt!");
						format(string,sizeof(string), "Du bist %d km/h gefahren und musst $%d BuÃŸgeld bezahlen.", speed, strafe);
						SendClientMessage(playerid, 0xFF6347AA, string);
					}
				}
			}
		}
	}
	return 1;
}

stock AddBlitzer(playerid,speed,radius) {
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid,x,y,z);
	for(new i = 0; i < sizeof(Blitzer); i++) {
  	    if(Blitzer[i][Erstellt] == 0) {
			Blitzer[i][BlitzerX] = x + 1.0;
		    Blitzer[i][BlitzerY] = y + 1.0;
		    Blitzer[i][BlitzerZ] = z;
		    Blitzer[i][Geschwindigkeit] = speed;
		    Blitzer[i][Radius] = radius;
		    Blitzer[i][Erstellt] = 1;
		    Blitzer[i][ID] = CreateObject(1278, x + 1.0, y + 1.0, z, 0.0, 0.0, 10);
		    return 1;
		}
	}
	return 0;
}
stock RemoveBlitzer(playerid) {
   	for(new i = 0; i < sizeof(Blitzer); i++) {
	   if(Blitzer[i][Erstellt] == 1) {
			if(IsPlayerInRangeOfPoint(playerid, Blitzer[i][eRadius], Blitzer[i][BlitzerX], Blitzer[i][BlitzerY], Blitzer[i][BlitzerZ])) {
				Blitzer[i][Erstellt] = 0;
    			Blitzer[i][BlitzerX] = 0.0;
		        Blitzer[i][BlitzerY] = 0.0;
	         	Blitzer[i][BlitzerZ] = 0.0;
           		DestroyObject(Blitzer[i][ID]);
             	return 1;
  	        }
  	    }
  	}
   	return 0;
}
stock RemoveAllBlitzer() {
   	for(new i = 0; i < sizeof(Blitzer); i++) {
		if(Blitzer[i][Erstellt] == 1) {
			Blitzer[i][Erstellt] = 0;
			Blitzer[i][BlitzerX] = 0.0;
   			Blitzer[i][BlitzerY] = 0.0;
     		Blitzer[i][BlitzerZ] = 0.0;
    		DestroyObject(Blitzer[i][ID]);
  	    }
  	}
   	return 0;
}
stock CountBlitzer() {
   	new anzahl = 0;
	for(new i = 0; i < sizeof(Blitzer); i++) {
		if(Blitzer[i][Erstellt] == 1) anzahl++;
  	}
   	return anzahl;
}
stock ErmittleGeschwindigkeit(playerid,bool:kmh) {
    new Float:x,Float:y,Float:z,Float:rtn;
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),x,y,z); else GetPlayerVelocity(playerid,x,y,z);
    rtn = floatsqroot(x*x+y*y+z*z);
    return kmh?floatround(rtn * 100 * 1.61):floatround(rtn * 100);
}
stock AddBlitzerxyz(Float:x,Float:y,Float:z,speed,radius) {
	for(new i = 0; i < sizeof(Blitzer); i++) {
	if(Blitzer[i][Erstellt] == 0) {
			Blitzer[i][BlitzerX] = x;
		    Blitzer[i][BlitzerY] = y;
		    Blitzer[i][BlitzerZ] = z;
		    Blitzer[i][Geschwindigkeit] = speed;
		    Blitzer[i][Radius] = radius;
			Blitzer[i][Erstellt] = 1;
		    return 1;
		}
	}
	return 0;
}

stock resetvaris(playerid)
{
ergebniss[playerid][Loginergebnis] = 0;
Counters[playerid][Logincounter] = 0;
PlayerInfo[playerid][pIsLogin] = false;
PlayerInfo[playerid][pCash] = 0;
PlayerInfo[playerid][playerskin] =0;
PlayerInfo[playerid][Team] = 0;
PlayerInfo[playerid][pKills] = 0;
PlayerInfo[playerid][pDeaths] = 0;
PlayerInfo[playerid][AdminLevel] = 0;
PlayerInfo[playerid][Autoschein] = 0;
PlayerInfo[playerid][Flugschein] = 0;
PlayerInfo[playerid][Bootschein] = 0;
PlayerInfo[playerid][Lastwagenschein] = 0;
PlayerInfo[playerid][Motorradschein] = 0;
}
stock checkpassword(playerid,key[])
{
format(checkpasswordsql,sizeof(checkpasswordsql), "SELECT  *FROM `players` WHERE `Name` = '%s' AND `Password` = '%s' LIMIT 1", oGetPlayerName(playerid),key);
mysql_query(checkpasswordsql);
mysql_store_result();

//printf("qery result %i",Loginergebnis);
if(mysql_num_rows() == 1)
{
SendClientMessage(playerid,COLOR_WHITE,"Login Erfolgreich");
//mysql_free_result();
ergebniss[playerid][Loginergebnis] = 1;
Loadaccount(playerid);
//accountLogged(playerid);
//mysql_free_result();
}
else
{
SendClientMessage(playerid,COLOR_WHITE,"Password Falsch");
ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_INPUT,Logintitle,Logintext,Login_Button1,Login_Button2);
ergebniss[playerid][Loginergebnis] = 0;
Counters[playerid][Logincounter]++;
}
return 1;
}
stock Loadaccount(playerid)
{

format(playersql,sizeof(playersql),"SELECT * FROM `players` WHERE `Name` = '%s'",oGetPlayerName(playerid));
mysql_query(playersql);
mysql_store_result();

if(mysql_fetch_row(playerresult))
mysql_fetch_field("Money",playersql); PlayerInfo[playerid][pCash] = strval(playersql);
mysql_fetch_field("Password",playersql); PlayerInfo[playerid][pPass] = strval(playersql);
mysql_fetch_field("Kills",playersql); PlayerInfo[playerid][pKills] = strval(playersql);
mysql_fetch_field("Deaths",playersql); PlayerInfo[playerid][pDeaths] = strval(playersql);
mysql_fetch_field("AdminLevel",playersql); PlayerInfo[playerid][AdminLevel] = strval(playersql);
mysql_fetch_field("Autoschein",playersql); PlayerInfo[playerid][Autoschein] = strval(playersql);
mysql_fetch_field("Flugschein",playersql); PlayerInfo[playerid][Flugschein] = strval(playersql);
mysql_fetch_field("Bootschein",playersql); PlayerInfo[playerid][Bootschein] = strval(playersql);
mysql_fetch_field("Lastwagenschein",playersql); PlayerInfo[playerid][Lastwagenschein] = strval(playersql);
mysql_fetch_field("Motorradschein",playersql); PlayerInfo[playerid][Motorradschein] = strval(playersql);
mysql_fetch_field("skin",playersql); PlayerInfo[playerid][playerskin] = strval(playersql);
mysql_fetch_field("Team",playersql); PlayerInfo[playerid][Team] = strval(playersql);
mysql_fetch_field("weapon1",playersql); Pweapons[playerid][waffe1] = strval(playersql);
mysql_fetch_field("weapon2",playersql); Pweapons[playerid][waffe2]= strval(playersql);
mysql_fetch_field("weapon3",playersql); Pweapons[playerid][waffe3] = strval(playersql);
mysql_fetch_field("weapon4",playersql); Pweapons[playerid][waffe4] = strval(playersql);
mysql_fetch_field("weapon5",playersql); Pweapons[playerid][waffe5] = strval(playersql);
mysql_fetch_field("weapon6",playersql); Pweapons[playerid][waffe6]= strval(playersql);
mysql_fetch_field("weapon7",playersql); Pweapons[playerid][waffe7] = strval(playersql);
mysql_fetch_field("weapon8",playersql); Pweapons[playerid][waffe8] = strval(playersql);
mysql_fetch_field("weapon9",playersql); Pweapons[playerid][waffe9] = strval(playersql);
mysql_fetch_field("weapon10",playersql); Pweapons[playerid][waffe10] = strval(playersql);
mysql_fetch_field("weapon11",playersql); Pweapons[playerid][waffe11] = strval(playersql);
mysql_fetch_field("weapon12",playersql); Pweapons[playerid][waffe12] = strval(playersql);
mysql_fetch_field("weapon13",playersql); Pweapons[playerid][waffe13]= strval(playersql);
mysql_fetch_field("weapon1_ammo",playersql); Pammo[playerid][ammo1] = strval(playersql);
mysql_fetch_field("weapon2_ammo",playersql); Pammo[playerid][ammo2] = strval(playersql);
mysql_fetch_field("weapon3_ammo",playersql); Pammo[playerid][ammo3] = strval(playersql);
mysql_fetch_field("weapon4_ammo",playersql); Pammo[playerid][ammo4] = strval(playersql);
mysql_fetch_field("weapon5_ammo",playersql); Pammo[playerid][ammo5] = strval(playersql);
mysql_fetch_field("weapon6_ammo",playersql); Pammo[playerid][ammo6] = strval(playersql);
mysql_fetch_field("weapon7_ammo",playersql); Pammo[playerid][ammo7] = strval(playersql);
mysql_fetch_field("weapon8_ammo",playersql); Pammo[playerid][ammo8]  = strval(playersql);
mysql_fetch_field("weapon9_ammo",playersql); Pammo[playerid][ammo9] = strval(playersql);
mysql_fetch_field("weapon10_ammo",playersql); Pammo[playerid][ammo10] = strval(playersql);
mysql_fetch_field("weapon11_ammo",playersql); Pammo[playerid][ammo11] = strval(playersql);
mysql_fetch_field("weapon12_ammo",playersql); Pammo[playerid][ammo12] = strval(playersql);
mysql_fetch_field("weapon13_ammo",playersql); Pammo[playerid][ammo13] = strval(playersql);
oSetPlayerMoney(playerid,PlayerInfo[playerid][pCash]);
PlayerInfo[playerid][pIsLogin] = true;
PlayerInfo[playerid][Logged] = 1;
mysql_free_result();
if(PlayerInfo[playerid][AdminLevel] > 0)
{
SendClientMessage(playerid,COLOR_WHITE,"Wilkommen Admin");
}

return 1;
}
stock register_player(playerid,key[])
{
format(registersql,sizeof(registersql), "INSERT INTO `players` (Name, Password,Autoschein,AdminLevel,Bootschein,Flugschein,Lastwagenschein,Motorradschein,pos_x,pos_y,pos_z,pos_r) VALUES ('%s', '%s',0,0,0,0,0,0,839.1575,-2061.9944,12.8679,91.3850)", oGetPlayerName(playerid), key);
mysql_query(registersql);
SendClientMessage(playerid,COLOR_WHITE,"Du hast dich Erfolgreich Registriert");
ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_INPUT,Logintitle,Logintext,Login_Button1,Login_Button2);
mysql_free_result();
return 1;
}
stock getallwaepons(playerid)
{
GetPlayerWeaponData(playerid,1,Pweapons[playerid][waffe1],Pammo[playerid][ammo1]);
GetPlayerWeaponData(playerid,2,Pweapons[playerid][waffe2],Pammo[playerid][ammo2]);
GetPlayerWeaponData(playerid,3,Pweapons[playerid][waffe3],Pammo[playerid][ammo3]);
GetPlayerWeaponData(playerid,4,Pweapons[playerid][waffe4],Pammo[playerid][ammo4]);
GetPlayerWeaponData(playerid,5,Pweapons[playerid][waffe5],Pammo[playerid][ammo5]);
GetPlayerWeaponData(playerid,6,Pweapons[playerid][waffe6],Pammo[playerid][ammo6]);
GetPlayerWeaponData(playerid,7,Pweapons[playerid][waffe7],Pammo[playerid][ammo7]);
GetPlayerWeaponData(playerid,8,Pweapons[playerid][waffe8],Pammo[playerid][ammo8]);
GetPlayerWeaponData(playerid,9,Pweapons[playerid][waffe9],Pammo[playerid][ammo9]);
GetPlayerWeaponData(playerid,10,Pweapons[playerid][waffe10],Pammo[playerid][ammo10]);
GetPlayerWeaponData(playerid,11,Pweapons[playerid][waffe11],Pammo[playerid][ammo11]);
GetPlayerWeaponData(playerid,12,Pweapons[playerid][waffe12],Pammo[playerid][ammo12]);
GetPlayerWeaponData(playerid,13,Pweapons[playerid][waffe13],Pammo[playerid][ammo13]);
return 1;
}
stock givealldbweapons(playerid)
{
GivePlayerWeapon(playerid,Pweapons[playerid][waffe1],Pammo[playerid][ammo1]);
GivePlayerWeapon(playerid,Pweapons[playerid][waffe2],Pammo[playerid][ammo2]);
GivePlayerWeapon(playerid,Pweapons[playerid][waffe3],Pammo[playerid][ammo3]);
GivePlayerWeapon(playerid,Pweapons[playerid][waffe4],Pammo[playerid][ammo4]);
GivePlayerWeapon(playerid,Pweapons[playerid][waffe5],Pammo[playerid][ammo5]);
GivePlayerWeapon(playerid,Pweapons[playerid][waffe6],Pammo[playerid][ammo6]);
GivePlayerWeapon(playerid,Pweapons[playerid][waffe7],Pammo[playerid][ammo7]);
GivePlayerWeapon(playerid,Pweapons[playerid][waffe8],Pammo[playerid][ammo8]);
GivePlayerWeapon(playerid,Pweapons[playerid][waffe9],Pammo[playerid][ammo9]);
GivePlayerWeapon(playerid,Pweapons[playerid][waffe10],Pammo[playerid][ammo10]);
GivePlayerWeapon(playerid,Pweapons[playerid][waffe11],Pammo[playerid][ammo11]);
GivePlayerWeapon(playerid,Pweapons[playerid][waffe12],Pammo[playerid][ammo12]);
GivePlayerWeapon(playerid,Pweapons[playerid][waffe13],Pammo[playerid][ammo13]);
return 1;
}
stock savewaepons(playerid)
{
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
getallwaepons(playerid);
format(saveweapons,sizeof(saveweapons),"UPDATE `players` SET ");
format(Updateweapons,sizeof(Updateweapons),"`weapon1`=%d,",Pweapons[playerid][waffe1]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon1_ammo`=%d,",Pammo[playerid][ammo1]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon2`=%d,",Pweapons[playerid][waffe2]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon2_ammo`=%d,",Pammo[playerid][ammo2]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon3`=%d,",Pweapons[playerid][waffe3]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon3_ammo`=%d,",Pammo[playerid][ammo3]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon4`=%d,",Pweapons[playerid][waffe4]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon4_ammo`=%d,",Pammo[playerid][ammo5]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon5`=%d,",Pweapons[playerid][waffe5]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon5_ammo`=%d,",Pammo[playerid][ammo5]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon6`=%d,",Pweapons[playerid][waffe6]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon6_ammo`=%d,",Pammo[playerid][ammo6]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon7`=%d,",Pweapons[playerid][waffe7]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon7_ammo`=%d,",Pammo[playerid][ammo7]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon8`=%d,",Pweapons[playerid][waffe8]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon8_ammo`=%d,",Pammo[playerid][ammo8]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon9`=%d,",Pweapons[playerid][waffe9]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon9_ammo`=%d,",Pammo[playerid][ammo9]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon10`=%d,",Pweapons[playerid][waffe10]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon10_ammo`=%d,",Pammo[playerid][ammo10]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon11`=%d,",Pweapons[playerid][waffe11]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon11_ammo`=%d,",Pammo[playerid][ammo11]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon12`=%d,",Pweapons[playerid][waffe12]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon12_ammo`=%d,",Pammo[playerid][ammo12]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon13`=%d,",Pweapons[playerid][waffe13]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons),"`weapon13_ammo`=%d",Pammo[playerid][ammo13]);
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
format(Updateweapons,sizeof(Updateweapons)," WHERE `Name`='%s'",oGetPlayerName(playerid));
strcat(saveweapons,Updateweapons,sizeof(saveweapons));
mysql_query(saveweapons);
//mysql_free_result();
return 1;
}
stock resetewapons(playerid)
{
Pweapons[playerid][waffe1] = 0;
Pweapons[playerid][waffe2] = 0;
Pweapons[playerid][waffe3] = 0;
Pweapons[playerid][waffe4] = 0;
Pweapons[playerid][waffe5] = 0;
Pweapons[playerid][waffe6] = 0;
Pweapons[playerid][waffe7] = 0;
Pweapons[playerid][waffe8] = 0;
Pweapons[playerid][waffe9] = 0;
Pweapons[playerid][waffe10] = 0;
Pweapons[playerid][waffe11] = 0;
Pweapons[playerid][waffe12] = 0;
Pweapons[playerid][waffe13] = 0;

// Monition

Pammo[playerid][ammo1] = 0;
Pammo[playerid][ammo2] = 0;
Pammo[playerid][ammo3] = 0;
Pammo[playerid][ammo4] = 0;
Pammo[playerid][ammo5] = 0;
Pammo[playerid][ammo6] = 0;
Pammo[playerid][ammo7] = 0;
Pammo[playerid][ammo8] = 0;
Pammo[playerid][ammo9] = 0;
Pammo[playerid][ammo10] = 0;
Pammo[playerid][ammo11] = 0;
Pammo[playerid][ammo12] = 0;
Pammo[playerid][ammo13] = 0;
return 1;
}
stock accountLogged(playerid)
{
if(PlayerInfo[playerid][pIsLogin] == false) return 1;
format(playerloggedsrc,sizeof(playerloggedsrc),"UPDATE `players` SET ");
format(playerlogged,sizeof(playerlogged),"`Logged`=1,");
strcat(playerloggedsrc,playerlogged,sizeof(playerloggedsrc));
format(playerlogged,sizeof(playerlogged),"`playerid`=%d",playerid);
strcat(playerloggedsrc,playerlogged,sizeof(playerloggedsrc));
format(playerlogged,sizeof(playerlogged)," WHERE `Name`='%s'",oGetPlayerName(playerid));
strcat(playerloggedsrc,playerlogged,sizeof(playerloggedsrc));
mysql_query(playerloggedsrc);
mysql_free_result();
return 1;
}
stock resetdb()
{
return 1;
}
public Worldtime(playerid)
{
	new string[256],year,month,day,hours,minutes,seconds;
	getdate(year, month, day), gettime(hours, minutes, seconds);
	format(string, sizeof string, "%d/%s%d/%s%d", day, ((month < 10) ? ("0") : ("")), month, (year < 10) ? ("0") : (""), year);
	TextDrawSetString(Date, string);
	format(string, sizeof string, "%s%d:%s%d:%s%d", (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
	TextDrawSetString(Time, string);
}
stock timebancheck(playerid)
{
printf("fucnkeion aufruf");
//	new query[256],

new	timestamp;
format(Selectban,sizeof(Selectban),"SELECT  *FROM `timeban` WHERE `IP` = '%s' AND `Name` = '%s' LIMIT 1",gPlayerIP[playerid],gPlayerName[playerid]);
mysql_query(Selectban);
mysql_store_result();
if(mysql_num_rows() == 1)
{
//	mysql_fetch_field("ID",Selectban); eergebnis=strval(Selectban);
mysql_fetch_field("Datum",Selectban); timestamp=strval(Selectban);
}
if(mysql_num_rows() == 1)
{
}
if(timestamp > Now()&&mysql_num_rows() == 1)
{
new string[128];
new zahl=timestamp-Now();
zahl=zahl/60;
format(string,128,"Du bist noch %d Minuten gebannt",zahl);
SendClientMessage(playerid,COLOR_RED,string);
return Kick(playerid);
}
else
{
printf("test2");
format(Selectban,sizeof(Selectban),"DELETE FROM `timeban` WHERE `IP`='%s' OR `Name`='%s'",gPlayerIP[playerid],gPlayerName[playerid]);
mysql_query(Selectban);
}
mysql_free_result();
return 1;
}

//hier auch ganz nach unten die stocks
stock mktime(hour,minute,second,day,month,year)
{
	new timestamp2;

	timestamp2 = second + (minute * 60) + (hour * 3600);

	new days_of_month[12];

	if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) {
			days_of_month = {31,29,31,30,31,30,31,31,30,31,30,31}; // Schaltjahr
		} else {
			days_of_month = {31,28,31,30,31,30,31,31,30,31,30,31}; // keins
		}
	new days_this_year = 0;
	days_this_year = day;
	if(month > 1) { // No January Calculation, because its always the 0 past months
		for(new i=0; i<month-1;i++) {
			days_this_year += days_of_month[i];
		}
	}
	timestamp2 += days_this_year * 86400;

	for(new j=1970;j<year;j++) {
		timestamp2 += 31536000;
		if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) )  timestamp2 += 86400; // Schaltjahr + 1 Tag
	}

	return timestamp2;
}

stock Now()
{
	new hour,minute,second,year,month,day;
	gettime(hour, minute, second);
	getdate(year, month, day);
	return mktime(hour,minute,second,day,month,year);
}

stock timebanplayer(nickname[24],grund[128],playerIP[16],admin[24],dauer)
{
 	new query[256];
	format(query,sizeof(query),"INSERT INTO timeban (Name,Grund,IP,Admin,Datum) VALUES ('%s','%s','%s','%s','%d')",
	nickname,
	grund,
	playerIP,
	admin,
	dauer);
	mysql_query(query);
	mysql_free_result();
}
dcmd_unban(playerid,params[])
{
new unbanname[MAX_PLAYER_NAME];
new ungbann[MAX_QUERY];
if(sscanf(params,"s[24]",unbanname)) return SendClientMessage(playerid,COLOR_YELLOW,"Benutzung. /unban [NAME]");
//if(Spieler[playerid][pAdmin] < 1) return SendClientMessage(playerid,COLOR_RED,"Du bist kein Admin");
format(ungbann,sizeof(ungbann),"DELETE FROM `timeban `Name`='%s'",unbanname);
mysql_query(ungbann);
if(mysql_num_rows() == 1)
{
SendClientMessage(playerid,COLOR_WHITE,"Erfolgreich Entbannt");
}
else
{
SendClientMessage(playerid,COLOR_WHITE,"Unban Fehlgeschlägen");
}
return 1;
}