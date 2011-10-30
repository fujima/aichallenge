open Ants
open Batteries
open Std


let tr s = 
  let len = String.length s in
  let ans = String.make (1 + len) '\n' in
    String.blit s 0 ans 0 len;
    ddebug ans

let not_water state loc =
  (state#get_tile loc) <> `Water

let rec try_step state ant d =
  if not_water state (state#step_dir ant#loc d) then
    begin
      tr <| string_of_dir d;
      state#issue_order (ant#loc, d);
      false
    end
  else true

let step_ant state ant =
  ignore <| List.for_all (try_step state ant) [`N; `E; `S; `W]

let rec step_ants state my_l =
  List.iter (step_ant state) my_l

let mybot_engine state =
  if state#turn = 0 then state#finish_turn ()
  else
    begin
      state#update_vision;
      step_ants state state#my_ants;
      state#finish_turn ()
    end

let _ = loop mybot_engine
