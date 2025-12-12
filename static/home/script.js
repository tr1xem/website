// Most of this code is copied from https://daudix.one/
// Consts
//
const lastFmUser = "tr1x_em";
const lastFmApiKey = "1747901e170276677d1d0447cf6519b0";
const lastFmPlayer = document.getElementById("player");
const lastFmCover = document.getElementById("cover");
const lastFmTitle = document.getElementById("player-title");
const lastFmTitleContainer = document.getElementById("player-title-container");
const lastFmArtist = document.getElementById("player-artist");
const lastFmArtistContainer = document.getElementById(
    "player-artist-container",
);
const lastFmLink = document.getElementById("player-go");

const userID = 885063317079592961n;
const discordStatus = document.getElementById("online-indicator");
const discordStatusText = document.getElementById("online-indicator-text");
const clock = document.getElementById("clock");

let lastDiscordStatus = "";
let lastTime = "";
let lastTrackID = null;
// Functions
// Last.fm
async function fetchLastFm() {
    try {
        // Replace my username and API key if you're going to use this
        const res = await fetch(
            `https://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=${lastFmUser}&api_key=${lastFmApiKey}&format=json&limit=1`,
        );
        const data = await res.json();
        const track = data.recenttracks?.track?.[0];
        if (!track) return;

        const trackID = track.mbid || track.url;
        const isPlaying = track["@attr"]?.nowplaying === "true";

        if (
            trackID !== lastTrackID ||
            isPlaying !== lastFmPlayer.classList.contains("playing")
        ) {
            lastTrackID = trackID;

            lastFmTitle.textContent = track.name;
            lastFmArtist.textContent = track.artist["#text"];
            lastFmCover.src =
                track.image.find((img) => img.size === "medium")?.["#text"] ||
                "home/image-missing.svg";
            lastFmLink.href = track.url;

            lastFmPlayer.classList.toggle("playing", isPlaying);

            updateMarquees();
        }
    } catch (e) {
        console.error("Failed to fetch now playing track:", e);
    }
}
//DISCORD
async function fetchDiscordStatus() {
    try {
        const url = "https://api.lanyard.rest/v1/users/" + userID;
        const res = await fetch(url);
        const data = await res.json();
        const status = data.data.discord_status;

        if (status !== lastDiscordStatus) {
            lastDiscordStatus = status;

            discordStatus.classList.remove("online", "idle", "dnd", "offline");
            discordStatus.classList.add(status);

            switch (status) {
                case "online":
                    discordStatusText.innerHTML = "Online";
                    break;
                case "idle":
                    discordStatusText.innerHTML = "Idle";
                    break;
                case "dnd":
                    discordStatusText.innerHTML = "DND";
                    break;
                case "offline":
                    discordStatusText.innerHTML = "Offline";
                    break;
            }
        }
    } catch (error) {
        console.error("Error fetching Lanyard data:", error);
        discordStatusText.innerHTML = "N/A";
    }
}

// Clock
function updateClock() {
    const options = {
        // No, I'm not in Moscow, just so happens the timezone is the same there
        timeZone: "Asia/Kolkata",
        hour: "2-digit",
        minute: "2-digit",
        hour12: true,
    };

    const localTime = new Date().toLocaleString("en-IN", options);

    if (localTime !== lastTime) {
        clock.textContent = localTime;
        lastTime = localTime;
    }
}

// Main
document.addEventListener("DOMContentLoaded", function () {
    fetchLastFm();
    setInterval(fetchLastFm, 10000);

    updateClock();
    setInterval(updateClock, 1000);

    fetchDiscordStatus();
    setInterval(fetchDiscordStatus, 10000);
});
