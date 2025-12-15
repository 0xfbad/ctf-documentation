{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = nixpkgs.legacyPackages.${system};
			in {
				devShells.default = pkgs.mkShell {
					packages = [ pkgs.uv ];
					shellHook = ''
						if [ ! -f .venv/bin/activate ]; then
							uv venv
						fi
						source .venv/bin/activate
						uv pip install -q zensical

						echo ""
						echo "available commands:"
						echo "  zensical serve    start dev server at localhost:8000"
						echo "  zensical build    generate static site to site/"
						echo ""
					'';
				};
			});
}
