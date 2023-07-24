ARG VARIANT=0-jammy
FROM mcr.microsoft.com/devcontainers/base:${VARIANT}

USER vscode
WORKDIR /tmp

# Glua API Snippets is a direct dependency for our library.
RUN curl -OL "https://github.com/luttje/glua-api-snippets/archive/refs/heads/lua-language-server-addon.zip" \
	&& unzip "lua-language-server-addon.zip" -d ~/ \
	&& rm "lua-language-server-addon.zip"