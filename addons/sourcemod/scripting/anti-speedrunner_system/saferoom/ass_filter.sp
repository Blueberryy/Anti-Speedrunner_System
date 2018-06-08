// Filter Option
bool g_bFilterStarted;
ConVar g_cvASSFilterBlockEnable;
ConVar g_cvASSFilterBlockMode;
ConVar g_cvASSFilterBlockOptions;

void vFilterCvars()
{
	g_cvASSFilterBlockEnable = ASS_ConVar("assfilter_blockenable", "1", "Punish blocked door users?\n(0: OFF)\n(1: ON)");
	g_cvASSFilterBlockMode = ASS_ConVar("assfilter_blockmode", "1", "Combine punishment options or randomly pick one?\n(0: Combine)\n(1: Pick one)");
	g_cvASSFilterBlockOptions = ASS_ConVar("assfilter_blockoptions", "QqWweErRtTuUIiOopPAasSdDfFgGHhJjkKLlcCvVbBnNMm", "Which system options do you want to use to deal with blocked door users?\nCombine letters in any order for different results.\nRepeat the same letter to increase its chance of being chosen.\nCharacter limit: 52\n(A or a: Slow)\n(B or b: Drug)\n(C or c: Blindness)\n(D or d: Shove)\n(E or e: Shake)\n(F or f: Freeze)\n(G or g: Inversion)\n(H or h: Restart)\n(I or i: Warp)\n(J or j: Ammunition)\n(K or k: Disarmament)\n(L or l: Hurt)\n(M or m: Fire)\n(N or n: Health)\n(O or o: Vision)\n(P or p: Incapacitation)\n(Q or q: Rocket)\n(R or r: Shock)\n(S or s: Explosion)\n(T or t: Puke)\n(U or u: Chase)\n(V or v: Acidity, switches to Puke in L4D1.)\n(W or w: Charge, switches to Chase in L4D1.)\n(X or x: Idle)\n(Y or y: Thirdperson, switches to Idle in L4D1.)\n(Z or z: Exile)");
}

void vFilterSettings()
{
	g_bFilterStarted = false;
	g_bBFGKLVoteMenu = false;
}

void vFilterOption(int client, int entity)
{
	if (bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) && bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
	{
		if (g_iStrikeCount[client] >= g_cvASSStrikeLimit.IntValue && ((g_cvASSCountBots.BoolValue && iGetAbleSurvivorCount(true) > iGetBadSurvivorCount(true) && iGetHumanCount() > 1) || (!g_cvASSCountBots.BoolValue && iGetAbleSurvivorCount(false) > iGetBadSurvivorCount(false))))
		{
			if (bIsHumanSurvivor(client))
			{
				if (g_cvASSFilterBlockEnable.BoolValue)
				{
					g_cvASSFilterBlockMode.BoolValue ? vStrikeOptions(0, client, client, g_cvASSFilterBlockOptions) : vStrikeOptions(1, client, client, g_cvASSFilterBlockOptions);
				}
				bHasTranslationFile() ? PrintHintText(client, "%s %t", ASS_PREFIX, "FilteredOut", g_iStrikeCount[client], g_cvASSStrikeLimit.IntValue) : PrintHintText(client, "%s You have %d/%d strikes and cannot open the door!", ASS_PREFIX, g_iStrikeCount[client], g_cvASSStrikeLimit.IntValue);
			}
		}
		else
		{
			vEntryMode(entity);
			for (int iToucher = 1; iToucher <= MaxClients; iToucher++)
			{
				if (bIsHumanSurvivor(iToucher))
				{
					bHasTranslationFile() ? PrintToChat(iToucher, "%s %t", ASS_PREFIX01, "NoFilter", client, g_iStrikeCount[client], g_cvASSStrikeLimit.IntValue) : PrintToChat(iToucher, "%s %N has %d/%d strikes and opened the saferoom door!", ASS_PREFIX01, client, g_iStrikeCount[client], g_cvASSStrikeLimit.IntValue);
				}
			}
		}
	}
}