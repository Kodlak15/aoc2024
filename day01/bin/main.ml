open In_channel

let read_file filename =
  let channel = open_text filename in
  let contents = input_all channel in
  close channel;
  contents

let part_1 filename =
  let text = read_file filename in
  let lines = String.split_on_char '\n' text in
  let str_pairs =
    List.map (fun line -> Str.split (Str.regexp "[ \t]+") line) lines
  in
  let int_pairs =
    List.map
      (fun pair ->
        match pair with
        | [ a; b ] ->
            let a_int = int_of_string a in
            let b_int = int_of_string b in
            (a_int, b_int)
        | _ -> (0, 0))
      str_pairs
  in
  let left_list = List.map fst int_pairs |> List.sort compare in
  let right_list = List.map snd int_pairs |> List.sort compare in
  let int_pairs_to_compare = List.combine left_list right_list in
  let abs_diff (a, b) = abs (a - b) in
  let sum_of_differences =
    List.fold_left (fun acc pair -> acc + abs_diff pair) 0 int_pairs_to_compare
  in
  Printf.printf "Part 1:\nSum of differences: %d\n" sum_of_differences

let part_2 filename =
  let text = read_file filename in
  let lines = String.split_on_char '\n' text in
  let str_pairs =
    List.map (fun line -> Str.split (Str.regexp "[ \t]+") line) lines
  in
  let int_pairs =
    List.map
      (fun pair ->
        match pair with
        | [ a; b ] ->
            let a_int = int_of_string a in
            let b_int = int_of_string b in
            (a_int, b_int)
        | _ -> (0, 0))
      str_pairs
  in
  let left_list = List.map fst int_pairs in
  let right_list = List.map snd int_pairs in
  let similarity_score x lst =
    List.fold_left
      (fun acc y -> match x == y with true -> acc + 1 | false -> acc)
      0 lst
  in
  let total_similarity_score =
    List.fold_left
      (fun acc x -> acc + (x * similarity_score x right_list))
      0 left_list
  in
  Printf.printf "Part 2:\nSimilarity score: %d\n" total_similarity_score

let () =
  let filename = "input.txt" in
  try
    let _ = part_1 filename in
    let _ = part_2 filename in
    ()
  with Sys_error msg -> Printf.printf "Error occurred: %s\n" msg
