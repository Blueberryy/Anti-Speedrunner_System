// Filter Option
bool g_bFilterStarted;
ConVar g_cvASSFilterBlockEnable;
ConVar g_cvASSFilterBlockMode;
ConVar g_cvASSFilterBlockOptions;

void vFilterCvars()
{
	vCreateConVar(g_cvASSFilterBlockEnable, "assfilter_blockenable", "1", "Punish blocked door users?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSFilterBlockMode, "assfilter_blockmode", "1", "Combine punishment options or randomly pick one?\n(0: Combine)\n(1: Pick one)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSFilterBlockOptions, "assfilter_blockoptions", "QqWweErRtTyYuUIiOopPAasSdDfFgGHhJjkKLlXxcCvVbBnNMm", "Which system options do you want to use to deal with blocked door users?\nCombine letters in any order for different results.\nRepeat the same letter to increase its chance of being chosen.\nCharacter limit: 52\n(A or a: Slow)\n(B or b: Drug)\n(C or c: Blindness)\n(D or d: Shove)\n(E or e: Shake)\n(F or f: Freeze)\n(G or g: Inversion)\n(H or h: Restart)\n(I or i: Warp)\n(J or j: Ammunition)\n(K or k: Disarmament)\n(L or l: Hurt)\n(M or m: Mirror)\n(N or n: Fire)\n(O or o: Health)\n(P or p: Vision)\n(Q or q: Incapacitation)\n(R or r: Rocket)\n(S or s: Shock)\n(T or t: Explosion)\n(U or u: Puke)\n(V or v: Chase)\n(W or w: Acidity, switches to Puke in L4D1.)\n(X or x: Charge, switches to Chase in L4D1.)\n(Y or y: Idle)\n(Z or z: Exile)");
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
		if (g_iStrikeCount[client] >= g_cvASSStrikeStrikeLimit.IntValue && ((g_cvASSCountBots.BoolValue && iGetAbleSurvivorCount(true) > iGetBadSurvivorCount(true) && iGetHumanCount() > 1) || (!g_cvASSCountBots.BoolValue && iGetAbleSurvivorCount(false) > iGetBadSurvivorCount(false))))
		{
			if (bIsHumanSurvivor(client))
			{
				if (g_cvASSFilterBlockEnable.BoolValue)
				{
					g_cvASSFilterBlockMode.BoolValue ? vStrikeOptions(0, client, client, g_cvASSFilterBlockOptions) : vStrikeOptions(1, client, client, g_cvASSFilterBlockOptions);
				}
				bHasTranslationFile() ? PrintHintText(client, "%s %t", ASS_PREFIX, "FilteredOut", g_iStrikeCount[client], g_cvASSStrikeStrikeLimit.IntValue) : PrintHintText(client, "%s You have %d/%d strikes and cannot open the door!", ASS_PREFIX, g_iStrikeCount[client], g_cvASSStrikeStrikeLimit.IntValue);
			}
		}
		else
		{
			vEntryMode(entity);
			for (int iToucher = 1; iToucher <= MaxClients; iToucher++)
			{
				if (bIsHumanSurvivor(iToucher))
				{
					bHasTranslationFile() ? PrintToChat(iToucher, "%s %t", ASS_PREFIX01, "NoFilter", client, g_iStrikeCount[client], g_cvASSStrikeStrikeLimit.IntValue) : PrintToChat(iToucher, "%s %N has %d/%d strikes and opened the saferoom door!", ASS_PREFIX01, client, g_iStrikeCount[client], g_cvASSStrikeStrikeLimit.IntValue);
				}
				vResetStats(iToucher);
			}
		}
	}
}