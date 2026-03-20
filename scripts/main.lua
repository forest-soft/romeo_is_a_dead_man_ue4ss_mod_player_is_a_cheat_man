print("[PLAYER IS A CHEAT MAN] OK")

-- バスターズの強化の割合
-- パラメータG(2個目)、パラメータR(3個目)の倍率
local setting_busters_power_up_ratio = 100


-- エメラルドフロウジョンの獲得量アップの割合
local setting_emerald_flowsion_drop_ratio = 100


-- ロミオの攻撃力アップの割合
local setting_romeo_attack_up_ratio = 10



--[[
～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～
～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～
～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～
]]







ExecuteInGameThread(function()
	--[[
	★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆
	★☆★☆★☆★☆★☆★☆　バスターズ強化　★☆★☆★☆★☆★☆★☆
	★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆
	]]
	local dt_support_zombie_info = StaticFindObject("/Game/DataTable/GameParameter/DT_SupportZombieInfo.DT_SupportZombieInfo")
	if dt_support_zombie_info:IsValid() then
		print("バスターズ強化")
		
		-- Modを再読み込みした時に再度適用されないようにする。
		local is_enable = false
		
		local check_row = dt_support_zombie_info:FindRow("SZ_001")
		if check_row.CoolTime < 0.2 then
			-- クールタイムが書き換え後の「0.1」ならば適用済みとみなす。
			-- ※小数点以下の値の関係で若干ズレが出るので、0.2と比較する。
			print("バスターズ強化の適用スキップ")
			is_enable = true
		end
		
		
		if not(is_enable) then
			dt_support_zombie_info:ForEachRow(function(row_name, row_data)
				-- クールタイム短縮
				row_data.CoolTime = 0.1
				row_data.ParamaterAMin = 0.1
				row_data.ParamaterAMax = row_data.ParamaterAMin
				
				row_data.ParamaterBMin = row_data.ParamaterBMin * setting_busters_power_up_ratio
				row_data.ParamaterBMax = row_data.ParamaterBMax * setting_busters_power_up_ratio
				
				if row_data.ParamaterCMax < row_data.ParamaterCMin then
					-- 「ウィークンフラワー」や「グラハ・マラ」はレベル上昇に伴って数値が低くなるタイプなので、割合で数値を減らすようにする。
					row_data.ParamaterCMin = row_data.ParamaterCMin / setting_busters_power_up_ratio
					row_data.ParamaterCMax = row_data.ParamaterCMax / setting_busters_power_up_ratio
				else
					row_data.ParamaterCMin = row_data.ParamaterCMin * setting_busters_power_up_ratio
					row_data.ParamaterCMax = row_data.ParamaterCMax * setting_busters_power_up_ratio
				end
			end)
		end
	end
	
	
	--[[
	★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆
	★☆★☆★☆★☆　エメラルドフロウジョンの獲得量アップ　★☆★☆★☆★☆
	★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆
	]]
	local dt_enemy_status = StaticFindObject("/Game/DataTable/GameParameter/DT_EnemyStatus.DT_EnemyStatus")
	if dt_enemy_status:IsValid() then
		print("エメラルドフロウジョンの獲得量アップ")
		
		-- Modを再読み込みした時に再度適用されないようにする。
		local is_enable = false
		
		local check_row = dt_enemy_status:FindRow("WALKER")
		if check_row.ZombiePowder ~= 5.0 then
			-- デフォルトの「5.0」じゃなければ適用済みとみなす。
			print("エメラルドフロウジョンの獲得量アップの適用スキップ")
			is_enable = true
		end
		
		
		if not(is_enable) then
			dt_enemy_status:ForEachRow(function(row_name, row_data)
				row_data.ZombiePowder = row_data.ZombiePowder * setting_emerald_flowsion_drop_ratio
			end)
		end
	end
	
	
	--[[
	★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆
	★☆★☆★☆★☆★☆★☆　攻撃力アップ　★☆★☆★☆★☆★☆★☆
	★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆
	]]
	local dt_attack_romeo = StaticFindObject("/Game/DataTable/GameParameter/DT_Attack_Romeo.DT_Attack_Romeo")
	if dt_attack_romeo:IsValid() then
		print("攻撃力アップ")
		
		-- Modを再読み込みした時に再度適用されないようにする。
		local is_enable = false
		
		local check_row = dt_attack_romeo:FindRow("AIR_SLIDE_ATTACK")
		if check_row.Attack ~= 15.0 then
			-- デフォルトの「15.0」じゃなければ適用済みとみなす。
			print("攻撃力アップの適用スキップ")
			is_enable = true
		end
		
		
		if not(is_enable) then
			dt_attack_romeo:ForEachRow(function(row_name, row_data)
				row_data.Attack = row_data.Attack * setting_romeo_attack_up_ratio
				-- row_data.Break = row_data.Break * setting_romeo_attack_up_ratio
			end)
		end
	end
	
	
	--[[
	★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆
	★☆★☆★☆★☆★☆　アイテム確定ドロップ　★☆★☆★☆★☆★☆
	★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆
	]]
	local dt_item_drop_data = StaticFindObject("/Game/DataTable/GameParameter/DT_ItemDropData.DT_ItemDropData")
	if dt_item_drop_data:IsValid() then
		print("アイテム確定ドロップ")
		
		-- Modを再読み込みした時に再度適用されないようにする。
		local is_enable = false
		
		local check_row = dt_item_drop_data:FindRow("ItemDrop_Boss")
		if 0.2 < check_row.DropRate_02 then
			-- デフォルトの「0.1」より大きければ適用済みとみなす。
			-- ※小数点以下の値の関係で若干ズレが出るので、0.2と比較する。
			print("アイテム確定ドロップの適用スキップ")
			is_enable = true
		end
		
		
		if not(is_enable) then
			dt_item_drop_data:ForEachRow(function(row_name, row_data)
				-- 00、01、02の3個ドロップアイテムが設定されているので、末尾の一番レアなアイテムのドロップ率を上げる。
				if row_data.DropRate_02 ~= 0 then
					row_data.DropRate_02 = 1.0
				elseif row_data.DropRate_01 ~= 0 then
					row_data.DropRate_01 = 1.0
				else
					row_data.DropRate_00 = 1.0
				end
			end)
		end
	end
end)


