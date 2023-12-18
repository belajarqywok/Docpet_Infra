local ltn12 = require "ltn12"
local json = require "dkjson"
local https = require "ssl.https"
local http = require "socket.http"

local DiscordNotification = {}
DiscordNotification.__index = DiscordNotification

-- Construct
function DiscordNotification.new(
    discordId, discordToken, 
    commitMessage, commitTime, cloudRunUrl
)
    local self = setmetatable({}, DiscordNotification)

    self.url = string.format("https://discord.com/api/webhooks/%s/%s", discordId, discordToken)
    self.commitMessage = commitMessage
    self.commitTime = commitTime
    self.cloudRunUrl = cloudRunUrl

    return self
end

-- Create Discord Webhook payload
function DiscordNotification:createPayload()
    self.discordWebhookPayload = {
        username = "Mamank Garox",
        avatar_url = "https://qph.cf2.quoracdn.net/main-qimg-c2108cee7b7917f80d8f6182a7a0a8ee-lq",
        embeds = {
            {
                title = ":zap:  [ INFO ] Backend Update...",
                color = 65352,
                description = string.format(
                    "- **Message**: %s\n- **Time**: %s\n- **URL**: %s\n- **Docs**: [Swagger](%s/docs)\n",
                    self.commitMessage, self.commitTime,
                    self.cloudRunUrl, self.cloudRunUrl
                )
            }
        }
    }
end

-- Send deployment notification to Discord
function DiscordNotification:sendNotification()
    local payloadEncoded = json.encode(self.discordWebhookPayload)
    local responseBody = {}

    local response, statusCode, headers, statusLine = https.request {
        url = self.url,
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json",
            ["Content-Length"] = string.len(payloadEncoded)
        },
        source = ltn12.source.string(payloadEncoded),
        sink = ltn12.sink.table(responseBody)
    }

    if statusCode == 204 then
        print("[ SUCCESS ] Send Deployment Notification to Discord")
    else
        print("[ FAILED ] Send Deployment Notification to Discord")
    end
end

-- Args
local discordId = arg[1]
local discordToken = arg[2]
local commitMessage = arg[3]
local commitTime = arg[4]
local cloudRunUrl = arg[5]

local discordNotification = DiscordNotification.new(
    discordId, discordToken, 
    commitMessage, commitTime, cloudRunUrl
)

discordNotification:createPayload()
discordNotification:sendNotification()
