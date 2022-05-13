Config = {}

Config.Resource = GetCurrentResourceName()
Config.ResourcePrefix = "gdx_rpchat" -- resource prefix
Config.GetSharedObject = "esx:getSharedObject" -- esx getSharedObject
Config.EnableESXIdentity = true -- if you have ESX Identity enable this
Config.OnlyFirstname = true -- enable show only first name
Config.AdvertPrice = 50 -- set price for advert
Config.docNumber = 20 -- set doc repeat number
Config.UseTNotify = false -- if you use t-notify, enable this
Config.NotificationType = "esx" -- set your notification | esx, t-notify, okok, other
Config.UseCustomFont = false -- enable or disable custom font
Config.FontName = "Ypsylon" -- if enabled custom font set font name
Config.FontId = 13 -- if enabled custom font, set font id
Config.Locale = "cs" -- set your locale | en, cs, other

-- Chats commands
Config.MeCMD = "me" -- ME
Config.DoCMD = "do" -- DO
Config.DocCMD = "doc" -- DOC
Config.TryCMD = "try" -- TRY
Config.OznCMD = "announcement" -- Announcement
Config.ThiefCMD = "thief" -- Thief
Config.PoliceCMD = "pd" -- Police
Config.SheriffCMD = "sd" -- Sheriff
Config.JailCMD = "jail" -- Jail
Config.GovernmentCMD = "government" -- Government
Config.AmbulanceCMD = "ems" -- Ambulance
Config.AdvertCMD = "ad" -- Advert
Config.CubeCMD = "cube" -- cube command
Config.CoinCMD = "coin" -- coin command
Config.HereCMD = "zde" -- here command

-- Chats jobs
Config.PoliceJob = "police" -- police job name
Config.SheriffJob = "sheriff" -- sheriff job name
Config.JailJob = "jail" -- jail job name
Config.GovernmentJob = "government" -- government job name
Config.AmbulanceJob = "ambulance" -- ambulance job name

-- Chats colors
Config.LoocColor = '0, 64, 255, 1.0' -- LOOC
Config.MeColor = '251, 0, 255, 1.0' -- ME
Config.DoColor = '0, 116, 255, 1.0' -- DO
Config.DocColor = '0, 116, 255, 1.0' -- DOC
Config.TryColor = '230, 126, 34, 1.0' -- TRY
Config.OznColor = '255, 0, 0, 1.0' -- Announcement
Config.ThiefColor = '52, 52, 52, 1.0' -- Thief
Config.PoliceColor = '0, 0, 255, 1.0' -- Police
Config.SheriffColor = '255, 180, 0, 1.0' -- Sheriff
Config.JailColor = '20, 20, 20, 1.0' -- Jail
Config.GovernmentColor = '255, 230, 0, 1.0' -- Government
Config.AmbulanceColor = '255, 0, 0, 1.0' -- Ambulance
Config.AdvertColor = '255, 191, 0, 1.0' -- Advert

Config.JobsChat = {
    [1] = {
        cmd = "hayesauto",
        job = "hayesauto",
        job_label = "Hayes Auto",
        name = "Hayes Auto",
        color = "131, 145, 146, 1.0"
    },
    [2] = {
        cmd = "cafecoolbeans",
        job = "cafecoolbeans",
        job_label = "Cafe Cool Beans",
        name = "Cafe Cool Beans",
        color = "240, 10, 120, 1.0"
    },
    [3] = {
        cmd = "vigneron",
        job = "vigneron",
        job_label = "Vigneron",
        name = "Vigneron",
        color = "210, 10, 240, 1.0"
    },
    [4] = {
        cmd = "maisonette",
        job = "maisonette",
        job_label = "Maisonette",
        name = "Maisonette 10",
        color = "70, 0, 70, 1.0"
    }
}