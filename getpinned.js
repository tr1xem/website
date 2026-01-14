const https = require("https");
const fs = require("fs");

const token = process.env.ZOLATOKEN; // must be set
const username = "tr1xem";

const query = {
    query: `
    query($login: String!) {
      user(login: $login) {
        pinnedItems(first: 6, types: REPOSITORY) {
          nodes {
            ... on Repository {
              name
              description
              url
              stargazerCount
              forkCount
              primaryLanguage {
                name
                color
              }
            }
          }
        }
      }
    }
  `,
    variables: { login: username },
};

// Convert query object to JSON string
const body = JSON.stringify(query);

const options = {
    hostname: "api.github.com",
    path: "/graphql",
    method: "POST",
    headers: {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
        "User-Agent": "nodejs-no-modules",
        "Content-Length": Buffer.byteLength(body),
    },
};

const req = https.request(options, (res) => {
    let data = "";
    res.on("data", (chunk) => (data += chunk));
    res.on("end", () => {
        try {
            const json = JSON.parse(data);
            fs.writeFileSync(
                "static/github-pinned.json",
                JSON.stringify(json, null, 2),
            );
            console.log("Saved pinned repos JSON!");
        } catch (e) {
            console.error("Failed to parse JSON:", e, data);
        }
    });
});

req.on("error", (e) => console.error(e));

// Send the stringified body
req.write(body);
req.end();
