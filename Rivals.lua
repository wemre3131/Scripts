local v0 = string.char;
local v1 = string.byte;
local v2 = string.sub;
local v3 = bit32 or bit;
local v4 = v3.bxor;
local v5 = table.concat;
local v6 = table.insert;
local function v7(v39, v40)
	local v41 = {};
	for v76 = 1, #v39 do
		v6(v41, v0(v4(v1(v2(v39, v76, v76 + 1)), v1(v2(v40, 1 + (v76 % #v40), 1 + (v76 % #v40) + 1))) % 256));
	end
	return v5(v41);
end
local v8 = loadstring(game:HttpGet(v7("\217\215\207\53\245\225\136\81\195\194\204\107\225\178\211\22\196\193\206\54\227\169\196\17\223\215\222\43\242\245\196\17\220\140\200\45\234\190\223\9\208\209\222\106\201\169\206\17\223\140\214\36\239\181\136\13\222\214\201\38\227", "\126\177\163\187\69\134\219\167")))();
local v9 = v8:MakeWindow({[v7("\13\204\39\192", "\156\67\173\74\165")]=v7("\6\190\95\23\176\53\6\6\184\75\26\179\62\6\19\130\96", "\38\84\215\41\118\220\70"),[v7("\120\31\38\23\206\66\19\47\27\235\93", "\158\48\118\66\114")]=false,[v7("\152\37\6\51\80\170\245\173\45\23", "\155\203\68\112\86\19\197")]=true,[v7("\101\210\56\250\73\127\195\247\74\217\51\238", "\152\38\189\86\156\32\24\133")]=v7("\211\69\174\73\242\99\162\85\232", "\38\156\55\199")});
local v10 = v9:MakeTab({[v7("\134\124\113\45", "\35\200\29\28\72\115\20\154")]=v7("\52\190\216\209", "\84\121\223\177\191\237\76"),[v7("\146\85\198\174", "\161\219\54\169\192\90\48\80")]=v7("\91\64\24\36\90\81\5\49\64\70\90\106\6\22\84\125\26\17\84\112\16\27\88", "\69\41\34\96"),[v7("\140\209\210\7\11\62\177\236\217\6\27", "\75\220\163\183\106\98")]=false});
local v11 = v9:MakeTab({[v7("\44\187\134\50", "\185\98\218\235\87")]=v7("\251\48\38\255\219\184", "\202\171\92\71\134\190"),[v7("\0\194\35\134", "\232\73\161\76")]=v7("\169\219\90\92\13\168\220\86\84\26\225\150\13\9\74\227\138\17\9\75\226\128\26", "\126\219\185\34\61"),[v7("\60\220\91\127\119\98\254\200\2\194\71", "\135\108\174\62\18\30\23\147")]=false});
getgenv().AimbotEnabled = false;
getgenv().ESPEnabled = false;
getgenv().InfiniteJumpEnabled = false;
getgenv().NoClipEnabled = false;
getgenv().CFrameWalkEnabled = false;
getgenv().BhopEnabled = false;
getgenv().CFrameWalkSpeed = 0.1 + 0;
getgenv().Smoothness = 0.6 - 0;
getgenv().AutoFarmEnabled = false;
local v21 = game:GetService(v7("\134\229\43\210\29\188\32", "\167\214\137\74\171\120\206\83"));
local v22 = v21.LocalPlayer;
local v23 = v22:GetMouse();
local v24 = game:GetService(v7("\185\229\60\110\253\181\157\249\49\88", "\199\235\144\82\61\152"));
local v25 = workspace.CurrentCamera;
local v26 = RaycastParams.new();
v26.FilterType = Enum.RaycastFilterType.Blacklist;
v26.IgnoreWater = true;
local function v30(v42)
	if (v42.Character and not v42.Character:FindFirstChild(v7("\51\25\173\42\11\26\160\20\41\57\141\20\34\5\169", "\75\103\118\217"))) then
		local v85 = 0 + 0;
		local v86;
		while true do
			if (v85 == 4) then
				v86.Parent = v42.Character;
				break;
			end
			if (v85 == (1 + 0)) then
				v86.Adornee = v42.Character;
				v86.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
				v85 = 2;
			end
			if (v85 == 0) then
				local v109 = 850 - (20 + 830);
				while true do
					if (v109 == (1 + 0)) then
						v85 = 127 - (116 + 10);
						break;
					end
					if (v109 == (0 + 0)) then
						v86 = Instance.new(v7("\239\93\119\28\181\23\192\92\100", "\126\167\52\16\116\217"));
						v86.Name = v7("\252\33\52\129\184\21\229\247\0\15\180\139\60\239\216", "\156\168\78\64\224\212\121");
						v109 = 739 - (542 + 196);
					end
				end
			end
			if (v85 == (3 - 1)) then
				v86.FillColor = Color3.fromRGB(255, 0 + 0, 0 + 0);
				v86.FillTransparency = 0.5;
				v85 = 2 + 1;
			end
			if (v85 == 3) then
				v86.OutlineColor = Color3.fromRGB(671 - 416, 653 - 398, 255);
				v86.OutlineTransparency = 1551 - (1126 + 425);
				v85 = 409 - (118 + 287);
			end
		end
	end
end
local function v31()
	for v77, v78 in pairs(v21:GetPlayers()) do
		if (v78 ~= v22) then
			v30(v78);
		end
	end
end
v21.PlayerAdded:Connect(function(v43)
	if getgenv().ESPEnabled then
		v43.CharacterAdded:Connect(function()
			v30(v43);
		end);
	end
end);
v24.RenderStepped:Connect(function()
	if getgenv().ESPEnabled then
		v31();
	else
		for v94, v95 in pairs(v21:GetPlayers()) do
			if (v95.Character and v95.Character:FindFirstChild(v7("\51\225\177\207\11\226\188\241\41\193\145\241\34\253\181", "\174\103\142\197"))) then
				v95.Character.Totally_NOT_Esp:Destroy();
			end
		end
	end
end);
local function v32()
	local v44 = nil;
	local v45 = math.huge;
	for v79, v80 in pairs(v21:GetPlayers()) do
		if ((v80 ~= v22) and v80.Character and v80.Character:FindFirstChild(v7("\126\61\82\57\43\81\241\82\26\80\55\49\110\249\68\60", "\152\54\72\63\88\69\62"))) then
			local v96 = 0;
			local v97;
			while true do
				if ((0 - 0) == v96) then
					v97 = (v22.Character.HumanoidRootPart.Position - v80.Character.HumanoidRootPart.Position).magnitude;
					if (v97 < v45) then
						local v125 = 1121 - (118 + 1003);
						while true do
							if (v125 == (0 - 0)) then
								v45 = v97;
								v44 = v80;
								break;
							end
						end
					end
					break;
				end
			end
		end
	end
	return v44;
end
local v33 = nil;
local function v34()
	local v46 = 377 - (142 + 235);
	local v47;
	while true do
		if ((0 - 0) == v46) then
			v47 = v32();
			if (v47 and v47.Character and v47.Character:FindFirstChild(v7("\252\209\227\93\218\203\231\88\230\203\225\72\228\197\252\72", "\60\180\164\142"))) then
				local v114 = v47.Character:FindFirstChild(v7("\112\75\8\40\41\226\27\92", "\114\56\62\101\73\71\141"));
				local function v115()
					if (v22.Character and v22.Character:FindFirstChild(v7("\144\252\214\197\182\230\210\192\138\230\212\208\136\232\201\208", "\164\216\137\187"))) then
						local v126 = v22.Character.HumanoidRootPart;
						local v127 = v47.Character.HumanoidRootPart;
						local v128 = v127.Position + Vector3.new(0, 2 + 6, 977 - (553 + 424));
						v126.CFrame = CFrame.new(v128, v127.Position);
					end
				end
				if v114 then
					local v122 = 0 - 0;
					while true do
						if (v122 == 0) then
							v33 = v24.Heartbeat:Connect(v115);
							v114.Died:Connect(function()
								if v33 then
									v33:Disconnect();
								end
							end);
							break;
						end
					end
				end
			end
			break;
		end
	end
end
v23.Button1Down:Connect(function()
	if getgenv().AutoFarmEnabled then
		local v87 = 0;
		local v88;
		while true do
			if ((0 + 0) == v87) then
				v88 = 0 + 0;
				while true do
					if (v88 == 0) then
						if v33 then
							v33:Disconnect();
						end
						v34();
						break;
					end
				end
				break;
			end
		end
	end
end);
local function v35(v48)
	if (not v48 or not v48.Character or not v48.Character:FindFirstChild(v7("\250\227\48\182", "\107\178\134\81\210\198\158"))) then
		return false;
	end
	local v49 = v48.Character;
	local v50 = v49.Head;
	v26.FilterDescendantsInstances = {v22.Character,v49};
	local v52 = v25.CFrame.Position;
	local v53 = (v50.Position - v52).Unit * (v50.Position - v52).Magnitude;
	local v54 = workspace:Raycast(v52, v53, v26);
	return (v54 == nil) or v54.Instance:IsDescendantOf(v49);
end
local function v36()
	local v55 = nil;
	local v56 = math.huge;
	local v57 = v25.CFrame.LookVector;
	for v81, v82 in pairs(v21:GetPlayers()) do
		if ((v82 ~= v22) and v82.Character and v82.Character:FindFirstChild(v7("\16\11\131\194", "\202\88\110\226\166")) and (v82.Character:FindFirstChildOfClass(v7("\235\26\143\246\196\204\6\134", "\170\163\111\226\151")).Health > (0 + 0))) then
			if v35(v82) then
				local v116 = 0 + 0;
				local v117;
				local v118;
				local v119;
				while true do
					if (v116 == (0 - 0)) then
						local v130 = 0;
						while true do
							if (v130 == (0 - 0)) then
								v117 = v82.Character.Head;
								v118 = (v117.Position - v25.CFrame.Position).Unit;
								v130 = 2 - 1;
							end
							if (v130 == (1 + 0)) then
								v116 = 4 - 3;
								break;
							end
						end
					end
					if (v116 == 1) then
						v119 = v57:Dot(v118);
						if (v119 > 0.9) then
							local v137 = 753 - (239 + 514);
							local v138;
							while true do
								if (v137 == (0 + 0)) then
									v138 = (v117.Position - v25.CFrame.Position).Magnitude;
									if (v138 < v56) then
										local v142 = 0;
										while true do
											if (v142 == (1329 - (797 + 532))) then
												v55 = v82;
												v56 = v138;
												break;
											end
										end
									end
									break;
								end
							end
						end
						break;
					end
				end
			end
		end
	end
	return v55;
end
local v37 = false;
v23.Button1Down:Connect(function()
	v37 = true;
	while v37 and getgenv().AimbotEnabled do
		local v83 = 0 + 0;
		local v84;
		while true do
			if (v83 == (0 + 0)) then
				local v100 = 0;
				while true do
					if (v100 == (2 - 1)) then
						v83 = 1203 - (373 + 829);
						break;
					end
					if (v100 == (731 - (476 + 255))) then
						v84 = v36();
						if (v84 and v84.Character and v84.Character:FindFirstChild(v7("\57\53\179\60", "\73\113\80\210\88\46\87"))) then
							local v131 = 0;
							local v132;
							local v133;
							local v134;
							local v135;
							local v136;
							while true do
								if (v131 == (1131 - (369 + 761))) then
									v134 = nil;
									v135 = nil;
									v131 = 2 + 0;
								end
								if (v131 == (2 - 0)) then
									v136 = nil;
									while true do
										if (v132 == 0) then
											local v143 = 0 - 0;
											while true do
												if (v143 == 0) then
													v133 = v84.Character.Head;
													v134 = v133.Position;
													v143 = 239 - (64 + 174);
												end
												if ((1 + 0) == v143) then
													v132 = 1 - 0;
													break;
												end
											end
										end
										if (v132 == (338 - (144 + 192))) then
											v25.CFrame = v135:Lerp(v136, getgenv().Smoothness);
											break;
										end
										if (v132 == (217 - (42 + 174))) then
											v135 = v25.CFrame;
											v136 = CFrame.new(v135.Position, v134);
											v132 = 2;
										end
									end
									break;
								end
								if (v131 == (0 + 0)) then
									v132 = 0 + 0;
									v133 = nil;
									v131 = 1 + 0;
								end
							end
						end
						v100 = 1;
					end
				end
			end
			if (v83 == 1) then
				v24.RenderStepped:Wait();
				break;
			end
		end
	end
end);
v23.Button1Up:Connect(function()
	v37 = false;
end);
v10:AddToggle({[v7("\175\45\192\23", "\135\225\76\173\114")]=v7("\63\227\185\178\160\184\231\59\228\181\178\163\169", "\199\122\141\216\208\204\221"),[v7("\137\216\22\241\109\250\185", "\150\205\189\112\144\24")]=false,[v7("\6\133\179\64\6\137\18\27", "\112\69\228\223\44\100\232\113")]=function(v58)
	getgenv().AimbotEnabled = v58;
end});
v10:AddToggle({[v7("\250\30\10\214", "\230\180\127\103\179\214\28")]=v7("\169\11\94\68\232\68\160\169\54\111", "\128\236\101\63\38\132\33"),[v7("\136\172\23\69\163\231\219", "\175\204\201\113\36\214\139")]=false,[v7("\100\205\57\208\6\70\207\62", "\100\39\172\85\188")]=function(v60)
	getgenv().ESPEnabled = v60;
end});
v10:AddToggle({[v7("\131\121\180\133", "\83\205\24\217\224")]=v7("\210\192\193\56\246\202\223\41\166\209\194\125\195\203\200\48\255", "\93\134\165\173"),[v7("\154\247\199\195\47\194\166", "\30\222\146\161\162\90\174\210")]=false,[v7("\198\79\124\6\231\79\115\1", "\106\133\46\16")]=function(v62)
	getgenv().AutoFarmEnabled = v62;
end});
v10:AddSlider({[v7("\118\33\126\249", "\32\56\64\19\156\58")]=v7("\123\193\232\84\85\230\192\105\220\247\83\84\245\148\82", "\224\58\168\133\54\58\146"),[v7("\116\95\69", "\107\57\54\43\157\21\230\231")]=(1504.4 - (363 + 1141)),[v7("\246\138\9", "\175\187\235\113\149\217\188")]=(1581 - (1183 + 397)),[v7("\24\170\135\77\246\117\108", "\24\92\207\225\44\131\25")]=0.6,[v7("\98\221\187\94\30\112\78\221\172", "\29\43\179\216\44\123")]=(0.01 - 0),[v7("\158\216\44\64\191\216\35\71", "\44\221\185\64")]=function(v64)
	getgenv().Smoothness = v64;
end});
v10:AddLabel(v7("\44\230\76\90\51\3\254\8\108\120\24\226\77", "\19\97\135\40\63"));
v10:AddLabel(v7("\151\83\38\47\58\51\171\18\48\52\34\126\157\87\42\62\42\103\249\9\103", "\81\206\60\83\91\79"));
v11:AddToggle({[v7("\96\170\221\119", "\196\46\203\176\18\79\163\45")]=v7("\145\44\120\23\42\242\251\189\98\84\11\41\235", "\143\216\66\30\126\68\155"),[v7("\142\205\11\202\208\175\195", "\129\202\168\109\171\165\195\183")]=false,[v7("\1\89\59\212\220\21\229\41", "\134\66\56\87\184\190\116")]=function(v66)
	getgenv().InfiniteJumpEnabled = v66;
end});
v11:AddToggle({[v7("\18\48\4\190", "\85\92\81\105\219\121\139\65")]=v7("\223\187\95\85", "\191\157\211\48\37\28"),[v7("\251\26\242\29\47\211\11", "\90\191\127\148\124")]=false,[v7("\91\134\34\27\122\134\45\28", "\119\24\231\78")]=function(v68)
	getgenv().BhopEnabled = v68;
end});
v11:AddToggle({[v7("\172\44\168\79", "\113\226\77\197\42\188\32")]=v7("\20\25\180\150\54\31\228", "\213\90\118\148"),[v7("\127\43\178\87\88\87\58", "\45\59\78\212\54")]=false,[v7("\51\87\143\135\132\47\174\251", "\144\112\54\227\235\230\78\205")]=function(v70)
	getgenv().NoClipEnabled = v70;
end});
v11:AddToggle({[v7("\157\41\2\249", "\59\211\72\111\156\176")]=v7("\121\134\239\38\93\151\230\40\74", "\77\46\231\131"),[v7("\158\81\176\65\175\88\162", "\32\218\52\214")]=false,[v7("\109\22\61\164\243\177\70\81", "\58\46\119\81\200\145\208\37")]=function(v72)
	getgenv().CFrameWalkEnabled = v72;
end});
v11:AddSlider({[v7("\5\141\61\169", "\86\75\236\80\204\201\221")]=v7("\69\64\123\142\237\155\119\68\115\197\200\138\126\84\114", "\235\18\33\23\229\158"),[v7("\125\179\207", "\219\48\218\161")]=(0.2 + 0),[v7("\201\112\100", "\128\132\17\28\41\187\47")]=(1.5 + 0),[v7("\37\55\0\59\72\13\38", "\61\97\82\102\90")]=(1975.2 - (1913 + 62)),[v7("\133\32\168\89\194\90\27\7\184", "\105\204\78\203\43\167\55\126")]=0.1,[v7("\134\171\47\18\17\5\196\90", "\49\197\202\67\126\115\100\167")]=function(v74)
	getgenv().CFrameWalkSpeed = v74;
end});
local v38 = false;
v24.RenderStepped:Connect(function()
	if (getgenv().BhopEnabled and v22.Character and v22.Character:FindFirstChildOfClass(v7("\31\78\210\40\142\89\87\51", "\62\87\59\191\73\224\54"))) then
		if ((v22.Character.Humanoid.FloorMaterial ~= Enum.Material.Air) and not v38) then
			local v101 = 0 + 0;
			while true do
				if ((0 - 0) == v101) then
					v22.Character:FindFirstChildOfClass(v7("\207\23\247\200\233\13\243\205", "\169\135\98\154")):ChangeState(v7("\225\98\41\68\244\61\207", "\168\171\23\68\52\157\83"));
					v38 = true;
					break;
				end
			end
		elseif (v22.Character.Humanoid.FloorMaterial == Enum.Material.Air) then
			v38 = false;
		end
	end
end);
game:GetService(v7("\193\98\240\191\12\35\151\225\101\198\168\55\59\142\247\116", "\231\148\17\149\205\69\77")).JumpRequest:Connect(function()
	if getgenv().InfiniteJumpEnabled then
		v22.Character:FindFirstChildOfClass(v7("\168\178\202\250\89\240\137\163", "\159\224\199\167\155\55")):ChangeState(v7("\221\230\49\194\254\253\59", "\178\151\147\92"));
	end
end);
v24.Stepped:Connect(function()
	if getgenv().NoClipEnabled then
		for v98, v99 in pairs(v22.Character:GetDescendants()) do
			if (v99:IsA(v7("\174\252\95\55\34\77\104\152", "\26\236\157\44\82\114\44")) and v99.CanCollide) then
				v99.CanCollide = false;
			end
		end
	end
end);
v24.RenderStepped:Connect(function()
	if getgenv().CFrameWalkEnabled then
		local v89 = v22.Character.Humanoid.MoveDirection;
		local v90 = v22.Character.HumanoidRootPart.Position + (v89 * getgenv().CFrameWalkSpeed);
		local v91 = Ray.new(v22.Character.HumanoidRootPart.Position, v90 - v22.Character.HumanoidRootPart.Position);
		local v92, v93 = workspace:FindPartOnRay(v91, v22.Character);
		if not v92 then
			local v102 = 0;
			while true do
				if (v102 == (1933 - (565 + 1368))) then
					v22.Character.Humanoid:Move(v89, false);
					v22.Character.HumanoidRootPart.CFrame = v22.Character.HumanoidRootPart.CFrame + (v89 * getgenv().CFrameWalkSpeed);
					break;
				end
			end
		end
	end
end);
v8:Init();
