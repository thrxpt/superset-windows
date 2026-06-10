/**
 * Windows build overlay for the unofficial superset-windows builder
 * (https://github.com/thrxpt/superset-windows).
 *
 * Imports upstream electron-builder.ts and overrides only what Windows
 * distribution needs: zip+nsis targets and the auto-update publish repo.
 * The build workflow copies this file into upstream's apps/desktop/ and
 * passes it to electron-builder via --config.
 */
import type { Configuration } from "electron-builder";
import base from "./electron-builder";

const config: Configuration = {
	...base,
	win: {
		...base.win,
		target: [
			{ target: "zip", arch: ["x64"] },
			{ target: "nsis", arch: ["x64"] },
		],
		artifactName: "Superset-${version}-win-${arch}.${ext}",
	},
	// Auto-update must point at the repo that actually hosts Windows
	// artifacts. electron-updater on Windows only supports the NSIS
	// install; zip (scoop) users update through scoop instead.
	publish: {
		provider: "github",
		owner: "thrxpt",
		repo: "superset-windows",
	},
};

export default config;
