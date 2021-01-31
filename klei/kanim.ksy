meta:
  id: kanim
  file-extension: bytes
  endian: le

doc: "Parser for Klei anim files"
doc-ref: "https://example.com"

seq:
  - id: signature
    size: 4
    type: str
    encoding: utf-8
  - id: version
    type: u4
  - id: anim
    type: anim
    if: signature == "ANIM"
  - id: build
    type: build
    if: signature == "BILD"


types:
  anim:
    seq:
      - id: total_elements
        type: u4
      - id: total_frames
        type: u4
      - id: total_anims
        type: u4
      - id: anims
        type: animation
        repeat: expr
        repeat-expr: total_anims
      - id: max_visible_symbol_frames
        type: u4
      - id: hash_count
        type: u4
      - id: hash_table
        type: hash_table
        repeat: expr
        repeat-expr: hash_count
  
  animation:
    seq:
      - id: name
        type: sized_string
      - id: hash
        type: u4
      - id: bank
        type: bank
  
  bank:
    seq:
      - id: rate
        type: f4
      - id: frame_count
        type: u4
      - id: frames
        type: anim_frame
        repeat: expr
        repeat-expr: frame_count
  
  anim_frame:
    seq: 
      - id: pos
        type: vector2
      - id: size
        type: vector2
      - id: element_count
        type: u4
      - id: elements
        type: element
        repeat: expr
        repeat-expr: element_count
  
  element:
    seq:
      - id: image_hash
        type: u4
      - id: index
        type: u4
      - id: layer
        type: u4
      - id: flags
        type: u4
      - id: color
        type: color
      - id: matrix_1
        type: vector2
      - id: matrix_2
        type: vector2
      - id: matrix_3
        type: vector2
      - id: order
        type: f4
  
  build:
    seq:
      - id: total_symbols
        type: u4
      - id: total_frames
        type: u4
      - id: build_name
        type: sized_string
      - id: symbols
        type: symbol
        repeat: expr
        repeat-expr: total_symbols
      - id: total_hashes
        type: u4
      - id: hash_table
        type: hash_table
        repeat: expr
        repeat-expr: total_hashes
  
  symbol:
    seq:
      - id: hash
        type: u4
      - id: path
        type: u4
        if: _root.version > 9
      - id: color
        type: u4
      - id: flags
        type: u4
      - id: frame_count
        type: u4
      - id: frames
        type: frame
        repeat: expr
        repeat-expr: frame_count
  
  frame:
    seq:
      - id: frame_num
        type: u4
      - id: duration
        type: u4
      - id: image_index
        type: u4
      - id: pivot
        type: vector2
      - id: pivot_size
        type: vector2
      - id: pos_1
        type: vector2
      - id: pos_2
        type: vector2
  
  hash_table:
    seq:
      - id: hash
        type: u4
      - id: data
        type: sized_string
  
  sized_string:
    seq:
      - id: size
        type: u4
      - id: data
        type: str
        encoding: utf-8
        size: size
  
  vector2:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
  
  color:
    seq:
      - id: a
        type: f4
      - id: b
        type: f4
      - id: g
        type: f4
      - id: r
        type: f4
