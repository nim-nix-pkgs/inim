{
  description = ''Interactive Nim Shell / REPL / Playground'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-inim-0_2_5.flake = false;
  inputs.src-inim-0_2_5.ref   = "refs/tags/0.2.5";
  inputs.src-inim-0_2_5.owner = "inim-repl";
  inputs.src-inim-0_2_5.repo  = "INim";
  inputs.src-inim-0_2_5.dir   = "";
  inputs.src-inim-0_2_5.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-inim-0_2_5"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-inim-0_2_5";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}