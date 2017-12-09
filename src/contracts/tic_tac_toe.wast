(module
 (type $FUNCSIG$vj (func (param i64)))
 (type $FUNCSIG$vii (func (param i32 i32)))
 (type $FUNCSIG$ijjjii (func (param i64 i64 i64 i32 i32) (result i32)))
 (type $FUNCSIG$ijjii (func (param i64 i64 i32 i32) (result i32)))
 (type $FUNCSIG$ijji (func (param i64 i64 i32) (result i32)))
 (type $FUNCSIG$iii (func (param i32 i32) (result i32)))
 (import "env" "assert" (func $assert (param i32 i32)))
 (import "env" "load_i64" (func $load_i64 (param i64 i64 i64 i32 i32) (result i32)))
 (import "env" "read_message" (func $read_message (param i32 i32) (result i32)))
 (import "env" "remove_i64" (func $remove_i64 (param i64 i64 i32) (result i32)))
 (import "env" "require_auth" (func $require_auth (param i64)))
 (import "env" "store_i64" (func $store_i64 (param i64 i64 i32 i32) (result i32)))
 (import "env" "update_i64" (func $update_i64 (param i64 i64 i32 i32) (result i32)))
 (table 0 anyfunc)
 (memory $0 1)
 (data (i32.const 4) "\90A\00\00")
 (data (i32.const 16) "draw\00")
 (data (i32.const 32) "none\00")
 (data (i32.const 48) "challenger shouldn\'t be the same as host\00")
 (data (i32.const 96) "game already exists\00")
 (data (i32.const 128) "game doesn\'t exist!\00")
 (data (i32.const 160) "this is not your game!\00")
 (data (i32.const 192) "the game has ended!\00")
 (data (i32.const 224) "it\'s not your turn yet!\00")
 (data (i32.const 256) "not a valid movement!\00")
 (data (i32.const 288) "tic.tac.toe\00")
 (data (i32.const 304) "create\00")
 (data (i32.const 320) "message shorter than expected\00")
 (data (i32.const 352) "restart\00")
 (data (i32.const 368) "close\00")
 (data (i32.const 384) "move\00")
 (export "memory" (memory $0))
 (export "_ZN11tic_tac_toe13is_empty_cellERKh" (func $_ZN11tic_tac_toe13is_empty_cellERKh))
 (export "_ZN11tic_tac_toe17is_valid_movementERKNS_8movementERKNS_4gameE" (func $_ZN11tic_tac_toe17is_valid_movementERKNS_8movementERKNS_4gameE))
 (export "_ZN11tic_tac_toe10get_winnerERKNS_4gameE" (func $_ZN11tic_tac_toe10get_winnerERKNS_4gameE))
 (export "_ZN11tic_tac_toe12apply_createERKNS_6createE" (func $_ZN11tic_tac_toe12apply_createERKNS_6createE))
 (export "_ZN11tic_tac_toe13apply_restartERKNS_7restartE" (func $_ZN11tic_tac_toe13apply_restartERKNS_7restartE))
 (export "_ZN11tic_tac_toe11apply_closeERKNS_5closeE" (func $_ZN11tic_tac_toe11apply_closeERKNS_5closeE))
 (export "_ZN11tic_tac_toe10apply_moveERKNS_4moveE" (func $_ZN11tic_tac_toe10apply_moveERKNS_4moveE))
 (export "init" (func $init))
 (export "apply" (func $apply))
 (func $_ZN11tic_tac_toe13is_empty_cellERKh (param $0 i32) (result i32)
  (i32.eqz
   (i32.load8_u
    (get_local $0)
   )
  )
 )
 (func $_ZN11tic_tac_toe17is_valid_movementERKNS_8movementERKNS_4gameE (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (set_local $2
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.ge_u
     (tee_local $0
      (i32.add
       (i32.mul
        (i32.load
         (get_local $0)
        )
        (i32.const 3)
       )
       (i32.load offset=4
        (get_local $0)
       )
      )
     )
     (i32.load8_u offset=32
      (get_local $1)
     )
    )
   )
   (set_local $2
    (i32.eqz
     (i32.load8_u
      (i32.add
       (i32.add
        (get_local $1)
        (get_local $0)
       )
       (i32.const 33)
      )
     )
    )
   )
  )
  (get_local $2)
 )
 (func $_ZN11tic_tac_toe10get_winnerERKNS_4gameE (param $0 i32) (result i64)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i64)
  (local $8 i64)
  (local $9 i64)
  (block $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (block $label$4
       (block $label$5
        (block $label$6
         (block $label$7
          (block $label$8
           (block $label$9
            (block $label$10
             (br_if $label$10
              (i32.ne
               (tee_local $1
                (i32.load8_u offset=33
                 (get_local $0)
                )
               )
               (tee_local $4
                (i32.load8_u
                 (i32.add
                  (get_local $0)
                  (i32.const 37)
                 )
                )
               )
              )
             )
             (br_if $label$9
              (i32.eq
               (get_local $1)
               (i32.load8_u
                (i32.add
                 (get_local $0)
                 (i32.const 41)
                )
               )
              )
             )
            )
            (block $label$11
             (br_if $label$11
              (i32.ne
               (tee_local $2
                (i32.load8_u
                 (i32.add
                  (get_local $0)
                  (i32.const 34)
                 )
                )
               )
               (get_local $4)
              )
             )
             (br_if $label$9
              (i32.eq
               (get_local $4)
               (i32.load8_u
                (i32.add
                 (get_local $0)
                 (i32.const 40)
                )
               )
              )
             )
            )
            (block $label$12
             (br_if $label$12
              (i32.ne
               (tee_local $5
                (i32.load8_u
                 (i32.add
                  (get_local $0)
                  (i32.const 35)
                 )
                )
               )
               (get_local $4)
              )
             )
             (br_if $label$9
              (i32.eq
               (get_local $4)
               (i32.load8_u
                (i32.add
                 (get_local $0)
                 (i32.const 39)
                )
               )
              )
             )
            )
            (br_if $label$8
             (i32.ne
              (tee_local $3
               (i32.load8_u
                (i32.add
                 (get_local $0)
                 (i32.const 36)
                )
               )
              )
              (get_local $4)
             )
            )
            (br_if $label$8
             (i32.ne
              (get_local $4)
              (i32.load8_u
               (i32.add
                (get_local $0)
                (i32.const 38)
               )
              )
             )
            )
           )
           (br_if $label$7
            (i32.eq
             (get_local $4)
             (i32.const 1)
            )
           )
           (br_if $label$3
            (i32.ne
             (get_local $4)
             (i32.const 2)
            )
           )
           (return
            (i64.load align=1
             (get_local $0)
            )
           )
          )
          (block $label$13
           (block $label$14
            (br_if $label$14
             (i32.ne
              (get_local $1)
              (get_local $2)
             )
            )
            (br_if $label$13
             (i32.eq
              (get_local $2)
              (get_local $5)
             )
            )
           )
           (br_if $label$6
            (i32.ne
             (get_local $1)
             (get_local $3)
            )
           )
           (br_if $label$6
            (i32.ne
             (get_local $1)
             (i32.load8_u
              (i32.add
               (get_local $0)
               (i32.const 39)
              )
             )
            )
           )
          )
          (br_if $label$5
           (i32.eq
            (get_local $1)
            (i32.const 2)
           )
          )
          (br_if $label$3
           (i32.ne
            (get_local $1)
            (i32.const 1)
           )
          )
          (return
           (i64.load offset=8 align=1
            (get_local $0)
           )
          )
         )
         (return
          (i64.load offset=8 align=1
           (get_local $0)
          )
         )
        )
        (block $label$15
         (block $label$16
          (br_if $label$16
           (i32.ne
            (get_local $5)
            (i32.load8_u
             (i32.add
              (get_local $0)
              (i32.const 38)
             )
            )
           )
          )
          (br_if $label$15
           (i32.eq
            (get_local $5)
            (i32.load8_u
             (i32.add
              (get_local $0)
              (i32.const 41)
             )
            )
           )
          )
         )
         (br_if $label$4
          (i32.ne
           (tee_local $5
            (i32.load8_u
             (i32.add
              (get_local $0)
              (i32.const 39)
             )
            )
           )
           (i32.load8_u
            (i32.add
             (get_local $0)
             (i32.const 40)
            )
           )
          )
         )
         (br_if $label$4
          (i32.ne
           (get_local $5)
           (i32.load8_u
            (i32.add
             (get_local $0)
             (i32.const 41)
            )
           )
          )
         )
        )
        (br_if $label$1
         (i32.eq
          (get_local $5)
          (i32.const 2)
         )
        )
        (br_if $label$3
         (i32.ne
          (get_local $5)
          (i32.const 1)
         )
        )
        (return
         (i64.load offset=8 align=1
          (get_local $0)
         )
        )
       )
       (return
        (i64.load align=1
         (get_local $0)
        )
       )
      )
      (br_if $label$2
       (i32.eqz
        (tee_local $2
         (i32.load8_u offset=32
          (get_local $0)
         )
        )
       )
      )
      (br_if $label$3
       (i32.eqz
        (get_local $1)
       )
      )
      (set_local $4
       (i32.const 1)
      )
      (loop $label$17
       (br_if $label$2
        (i32.ge_u
         (tee_local $1
          (i32.and
           (get_local $4)
           (i32.const 255)
          )
         )
         (get_local $2)
        )
       )
       (set_local $4
        (i32.add
         (get_local $4)
         (i32.const 1)
        )
       )
       (br_if $label$17
        (i32.load8_u
         (i32.add
          (i32.add
           (get_local $0)
           (get_local $1)
          )
          (i32.const 33)
         )
        )
       )
      )
     )
     (set_local $7
      (i64.const 0)
     )
     (set_local $6
      (i64.const 59)
     )
     (set_local $0
      (i32.const 32)
     )
     (set_local $9
      (i64.const 0)
     )
     (loop $label$18
      (block $label$19
       (block $label$20
        (block $label$21
         (block $label$22
          (block $label$23
           (br_if $label$23
            (i64.gt_u
             (get_local $7)
             (i64.const 3)
            )
           )
           (br_if $label$22
            (i32.gt_u
             (i32.and
              (i32.add
               (tee_local $4
                (i32.load8_s
                 (get_local $0)
                )
               )
               (i32.const -97)
              )
              (i32.const 255)
             )
             (i32.const 25)
            )
           )
           (set_local $4
            (i32.add
             (get_local $4)
             (i32.const 165)
            )
           )
           (br $label$21)
          )
          (set_local $8
           (i64.const 0)
          )
          (br_if $label$20
           (i64.le_u
            (get_local $7)
            (i64.const 11)
           )
          )
          (br $label$19)
         )
         (set_local $4
          (select
           (i32.add
            (get_local $4)
            (i32.const 208)
           )
           (i32.const 0)
           (i32.lt_u
            (i32.and
             (i32.add
              (get_local $4)
              (i32.const -49)
             )
             (i32.const 255)
            )
            (i32.const 5)
           )
          )
         )
        )
        (set_local $8
         (i64.shr_s
          (i64.shl
           (i64.extend_u/i32
            (get_local $4)
           )
           (i64.const 56)
          )
          (i64.const 56)
         )
        )
       )
       (set_local $8
        (i64.shl
         (i64.and
          (get_local $8)
          (i64.const 31)
         )
         (i64.and
          (get_local $6)
          (i64.const 4294967295)
         )
        )
       )
      )
      (set_local $0
       (i32.add
        (get_local $0)
        (i32.const 1)
       )
      )
      (set_local $7
       (i64.add
        (get_local $7)
        (i64.const 1)
       )
      )
      (set_local $9
       (i64.or
        (get_local $8)
        (get_local $9)
       )
      )
      (br_if $label$18
       (i64.ne
        (tee_local $6
         (i64.add
          (get_local $6)
          (i64.const -5)
         )
        )
        (i64.const -6)
       )
      )
      (br $label$0)
     )
    )
    (set_local $7
     (i64.const 0)
    )
    (set_local $6
     (i64.const 59)
    )
    (set_local $0
     (i32.const 16)
    )
    (set_local $9
     (i64.const 0)
    )
    (loop $label$24
     (block $label$25
      (block $label$26
       (block $label$27
        (block $label$28
         (block $label$29
          (br_if $label$29
           (i64.gt_u
            (get_local $7)
            (i64.const 3)
           )
          )
          (br_if $label$28
           (i32.gt_u
            (i32.and
             (i32.add
              (tee_local $4
               (i32.load8_s
                (get_local $0)
               )
              )
              (i32.const -97)
             )
             (i32.const 255)
            )
            (i32.const 25)
           )
          )
          (set_local $4
           (i32.add
            (get_local $4)
            (i32.const 165)
           )
          )
          (br $label$27)
         )
         (set_local $8
          (i64.const 0)
         )
         (br_if $label$26
          (i64.le_u
           (get_local $7)
           (i64.const 11)
          )
         )
         (br $label$25)
        )
        (set_local $4
         (select
          (i32.add
           (get_local $4)
           (i32.const 208)
          )
          (i32.const 0)
          (i32.lt_u
           (i32.and
            (i32.add
             (get_local $4)
             (i32.const -49)
            )
            (i32.const 255)
           )
           (i32.const 5)
          )
         )
        )
       )
       (set_local $8
        (i64.shr_s
         (i64.shl
          (i64.extend_u/i32
           (get_local $4)
          )
          (i64.const 56)
         )
         (i64.const 56)
        )
       )
      )
      (set_local $8
       (i64.shl
        (i64.and
         (get_local $8)
         (i64.const 31)
        )
        (i64.and
         (get_local $6)
         (i64.const 4294967295)
        )
       )
      )
     )
     (set_local $0
      (i32.add
       (get_local $0)
       (i32.const 1)
      )
     )
     (set_local $7
      (i64.add
       (get_local $7)
       (i64.const 1)
      )
     )
     (set_local $9
      (i64.or
       (get_local $8)
       (get_local $9)
      )
     )
     (br_if $label$24
      (i64.ne
       (tee_local $6
        (i64.add
         (get_local $6)
         (i64.const -5)
        )
       )
       (i64.const -6)
      )
     )
     (br $label$0)
    )
   )
   (return
    (i64.load align=1
     (get_local $0)
    )
   )
  )
  (get_local $9)
 )
 (func $_ZN11tic_tac_toe12apply_createERKNS_6createE (param $0 i32)
  (local $1 i32)
  (local $2 i64)
  (local $3 i32)
  (local $4 i64)
  (local $5 i64)
  (local $6 i64)
  (local $7 i64)
  (local $8 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $8
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 112)
    )
   )
  )
  (call $require_auth
   (i64.load offset=8
    (get_local $0)
   )
  )
  (call $assert
   (i64.ne
    (i64.load
     (get_local $0)
    )
    (i64.load offset=8
     (get_local $0)
    )
   )
   (i32.const 48)
  )
  (set_local $5
   (i64.const 0)
  )
  (set_local $4
   (i64.const 59)
  )
  (set_local $3
   (i32.const 32)
  )
  (set_local $6
   (i64.const 0)
  )
  (loop $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (block $label$4
       (block $label$5
        (br_if $label$5
         (i64.gt_u
          (get_local $5)
          (i64.const 3)
         )
        )
        (br_if $label$4
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $1
             (i32.load8_s
              (get_local $3)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $1
         (i32.add
          (get_local $1)
          (i32.const 165)
         )
        )
        (br $label$3)
       )
       (set_local $7
        (i64.const 0)
       )
       (br_if $label$2
        (i64.le_u
         (get_local $5)
         (i64.const 11)
        )
       )
       (br $label$1)
      )
      (set_local $1
       (select
        (i32.add
         (get_local $1)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $1)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $7
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $1)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $7
     (i64.shl
      (i64.and
       (get_local $7)
       (i64.const 31)
      )
      (i64.and
       (get_local $4)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (set_local $5
    (i64.add
     (get_local $5)
     (i64.const 1)
    )
   )
   (set_local $6
    (i64.or
     (get_local $7)
     (get_local $6)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $4
      (i64.add
       (get_local $4)
       (i64.const -5)
      )
     )
     (i64.const -6)
    )
   )
  )
  (i32.store8 offset=96
   (get_local $8)
   (i32.const 9)
  )
  (i64.store offset=88
   (get_local $8)
   (get_local $6)
  )
  (i64.store offset=64
   (get_local $8)
   (i64.load
    (get_local $0)
   )
  )
  (call $assert
   (i32.ne
    (call $load_i64
     (i64.load
      (tee_local $3
       (i32.add
        (get_local $0)
        (i32.const 8)
       )
      )
     )
     (i64.const -3778506236080876544)
     (i64.const 7035937633859534848)
     (i32.add
      (get_local $8)
      (i32.const 64)
     )
     (i32.const 42)
    )
    (i32.const 42)
   )
   (i32.const 96)
  )
  (i64.store offset=16
   (get_local $8)
   (i64.load
    (get_local $0)
   )
  )
  (i64.store offset=24
   (get_local $8)
   (tee_local $2
    (i64.load
     (get_local $3)
    )
   )
  )
  (i64.store offset=32
   (get_local $8)
   (get_local $2)
  )
  (set_local $5
   (i64.const 0)
  )
  (set_local $4
   (i64.const 59)
  )
  (set_local $3
   (i32.const 32)
  )
  (set_local $6
   (i64.const 0)
  )
  (loop $label$6
   (block $label$7
    (block $label$8
     (block $label$9
      (block $label$10
       (block $label$11
        (br_if $label$11
         (i64.gt_u
          (get_local $5)
          (i64.const 3)
         )
        )
        (br_if $label$10
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $1
             (i32.load8_s
              (get_local $3)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $1
         (i32.add
          (get_local $1)
          (i32.const 165)
         )
        )
        (br $label$9)
       )
       (set_local $7
        (i64.const 0)
       )
       (br_if $label$8
        (i64.le_u
         (get_local $5)
         (i64.const 11)
        )
       )
       (br $label$7)
      )
      (set_local $1
       (select
        (i32.add
         (get_local $1)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $1)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $7
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $1)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $7
     (i64.shl
      (i64.and
       (get_local $7)
       (i64.const 31)
      )
      (i64.and
       (get_local $4)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (set_local $5
    (i64.add
     (get_local $5)
     (i64.const 1)
    )
   )
   (set_local $6
    (i64.or
     (get_local $7)
     (get_local $6)
    )
   )
   (br_if $label$6
    (i64.ne
     (tee_local $4
      (i64.add
       (get_local $4)
       (i64.const -5)
      )
     )
     (i64.const -6)
    )
   )
  )
  (i32.store16
   (i32.add
    (get_local $8)
    (i32.const 56)
   )
   (i32.const 0)
  )
  (i64.store offset=40
   (get_local $8)
   (get_local $6)
  )
  (i64.store offset=48
   (get_local $8)
   (i64.const 9)
  )
  (drop
   (call $store_i64
    (get_local $2)
    (i64.const 7035937633859534848)
    (i32.add
     (get_local $8)
     (i32.const 16)
    )
    (i32.const 42)
   )
  )
  (i64.store
   (get_local $8)
   (tee_local $5
    (i64.load
     (get_local $0)
    )
   )
  )
  (i64.store offset=8
   (get_local $8)
   (i64.load
    (i32.add
     (get_local $0)
     (i32.const 8)
    )
   )
  )
  (drop
   (call $store_i64
    (get_local $5)
    (i64.const 8428183971854024704)
    (get_local $8)
    (i32.const 16)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 112)
   )
  )
 )
 (func $_ZN11tic_tac_toe13apply_restartERKNS_7restartE (param $0 i32)
  (local $1 i64)
  (local $2 i32)
  (local $3 i64)
  (local $4 i64)
  (local $5 i64)
  (local $6 i64)
  (local $7 i32)
  (local $8 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $8
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (call $require_auth
   (i64.load offset=16
    (get_local $0)
   )
  )
  (set_local $4
   (i64.const 0)
  )
  (set_local $3
   (i64.const 59)
  )
  (set_local $2
   (i32.const 32)
  )
  (set_local $5
   (i64.const 0)
  )
  (loop $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (block $label$4
       (block $label$5
        (br_if $label$5
         (i64.gt_u
          (get_local $4)
          (i64.const 3)
         )
        )
        (br_if $label$4
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $7
             (i32.load8_s
              (get_local $2)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $7
         (i32.add
          (get_local $7)
          (i32.const 165)
         )
        )
        (br $label$3)
       )
       (set_local $6
        (i64.const 0)
       )
       (br_if $label$2
        (i64.le_u
         (get_local $4)
         (i64.const 11)
        )
       )
       (br $label$1)
      )
      (set_local $7
       (select
        (i32.add
         (get_local $7)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $7)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $6
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $7)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $6
     (i64.shl
      (i64.and
       (get_local $6)
       (i64.const 31)
      )
      (i64.and
       (get_local $3)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $2
    (i32.add
     (get_local $2)
     (i32.const 1)
    )
   )
   (set_local $4
    (i64.add
     (get_local $4)
     (i64.const 1)
    )
   )
   (set_local $5
    (i64.or
     (get_local $6)
     (get_local $5)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $3
      (i64.add
       (get_local $3)
       (i64.const -5)
      )
     )
     (i64.const -6)
    )
   )
  )
  (i32.store8 offset=32
   (get_local $8)
   (i32.const 9)
  )
  (i64.store offset=24
   (get_local $8)
   (get_local $5)
  )
  (i64.store
   (get_local $8)
   (i64.load
    (get_local $0)
   )
  )
  (call $assert
   (i32.eq
    (call $load_i64
     (i64.load offset=8
      (get_local $0)
     )
     (i64.const -3778506236080876544)
     (i64.const 7035937633859534848)
     (get_local $8)
     (i32.const 42)
    )
    (i32.const 42)
   )
   (i32.const 128)
  )
  (call $assert
   (i32.or
    (i64.eq
     (tee_local $4
      (i64.load
       (i32.add
        (get_local $0)
        (i32.const 16)
       )
      )
     )
     (i64.load offset=8
      (get_local $8)
     )
    )
    (i64.eq
     (get_local $4)
     (i64.load
      (get_local $8)
     )
    )
   )
   (i32.const 160)
  )
  (block $label$6
   (br_if $label$6
    (i32.eqz
     (tee_local $7
      (i32.load8_u offset=32
       (get_local $8)
      )
     )
    )
   )
   (set_local $2
    (i32.add
     (get_local $8)
     (i32.const 33)
    )
   )
   (loop $label$7
    (i32.store8
     (get_local $2)
     (i32.const 0)
    )
    (set_local $2
     (i32.add
      (get_local $2)
      (i32.const 1)
     )
    )
    (br_if $label$7
     (tee_local $7
      (i32.add
       (get_local $7)
       (i32.const -1)
      )
     )
    )
   )
  )
  (i64.store offset=16
   (get_local $8)
   (tee_local $1
    (i64.load
     (i32.add
      (get_local $8)
      (i32.const 8)
     )
    )
   )
  )
  (set_local $4
   (i64.const 0)
  )
  (set_local $3
   (i64.const 59)
  )
  (set_local $2
   (i32.const 32)
  )
  (set_local $5
   (i64.const 0)
  )
  (loop $label$8
   (block $label$9
    (block $label$10
     (block $label$11
      (block $label$12
       (block $label$13
        (br_if $label$13
         (i64.gt_u
          (get_local $4)
          (i64.const 3)
         )
        )
        (br_if $label$12
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $7
             (i32.load8_s
              (get_local $2)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $7
         (i32.add
          (get_local $7)
          (i32.const 165)
         )
        )
        (br $label$11)
       )
       (set_local $6
        (i64.const 0)
       )
       (br_if $label$10
        (i64.le_u
         (get_local $4)
         (i64.const 11)
        )
       )
       (br $label$9)
      )
      (set_local $7
       (select
        (i32.add
         (get_local $7)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $7)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $6
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $7)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $6
     (i64.shl
      (i64.and
       (get_local $6)
       (i64.const 31)
      )
      (i64.and
       (get_local $3)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $2
    (i32.add
     (get_local $2)
     (i32.const 1)
    )
   )
   (set_local $4
    (i64.add
     (get_local $4)
     (i64.const 1)
    )
   )
   (set_local $5
    (i64.or
     (get_local $6)
     (get_local $5)
    )
   )
   (br_if $label$8
    (i64.ne
     (tee_local $3
      (i64.add
       (get_local $3)
       (i64.const -5)
      )
     )
     (i64.const -6)
    )
   )
  )
  (i64.store
   (i32.add
    (get_local $8)
    (i32.const 24)
   )
   (get_local $5)
  )
  (drop
   (call $update_i64
    (get_local $1)
    (i64.const 7035937633859534848)
    (get_local $8)
    (i32.const 42)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 48)
   )
  )
 )
 (func $_ZN11tic_tac_toe11apply_closeERKNS_5closeE (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i64)
  (local $4 i64)
  (local $5 i64)
  (local $6 i64)
  (local $7 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $7
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (call $require_auth
   (i64.load offset=8
    (get_local $0)
   )
  )
  (set_local $4
   (i64.const 0)
  )
  (set_local $3
   (i64.const 59)
  )
  (set_local $2
   (i32.const 32)
  )
  (set_local $5
   (i64.const 0)
  )
  (loop $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (block $label$4
       (block $label$5
        (br_if $label$5
         (i64.gt_u
          (get_local $4)
          (i64.const 3)
         )
        )
        (br_if $label$4
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $1
             (i32.load8_s
              (get_local $2)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $1
         (i32.add
          (get_local $1)
          (i32.const 165)
         )
        )
        (br $label$3)
       )
       (set_local $6
        (i64.const 0)
       )
       (br_if $label$2
        (i64.le_u
         (get_local $4)
         (i64.const 11)
        )
       )
       (br $label$1)
      )
      (set_local $1
       (select
        (i32.add
         (get_local $1)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $1)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $6
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $1)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $6
     (i64.shl
      (i64.and
       (get_local $6)
       (i64.const 31)
      )
      (i64.and
       (get_local $3)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $2
    (i32.add
     (get_local $2)
     (i32.const 1)
    )
   )
   (set_local $4
    (i64.add
     (get_local $4)
     (i64.const 1)
    )
   )
   (set_local $5
    (i64.or
     (get_local $6)
     (get_local $5)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $3
      (i64.add
       (get_local $3)
       (i64.const -5)
      )
     )
     (i64.const -6)
    )
   )
  )
  (i32.store8 offset=32
   (get_local $7)
   (i32.const 9)
  )
  (i64.store offset=24
   (get_local $7)
   (get_local $5)
  )
  (i64.store
   (get_local $7)
   (i64.load
    (get_local $0)
   )
  )
  (call $assert
   (i32.eq
    (call $load_i64
     (i64.load
      (i32.add
       (get_local $0)
       (i32.const 8)
      )
     )
     (i64.const -3778506236080876544)
     (i64.const 7035937633859534848)
     (get_local $7)
     (i32.const 42)
    )
    (i32.const 42)
   )
   (i32.const 128)
  )
  (drop
   (call $remove_i64
    (i64.load offset=8
     (get_local $7)
    )
    (i64.const 7035937633859534848)
    (get_local $7)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $7)
    (i32.const 48)
   )
  )
 )
 (func $_ZN11tic_tac_toe10apply_moveERKNS_4moveE (param $0 i32)
  (local $1 i32)
  (local $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i64)
  (local $8 i64)
  (local $9 i64)
  (local $10 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $10
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (call $require_auth
   (i64.load offset=16
    (get_local $0)
   )
  )
  (set_local $7
   (i64.const 0)
  )
  (set_local $6
   (i64.const 59)
  )
  (set_local $5
   (i32.const 32)
  )
  (set_local $8
   (i64.const 0)
  )
  (loop $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (block $label$4
       (block $label$5
        (br_if $label$5
         (i64.gt_u
          (get_local $7)
          (i64.const 3)
         )
        )
        (br_if $label$4
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $1
             (i32.load8_s
              (get_local $5)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $1
         (i32.add
          (get_local $1)
          (i32.const 165)
         )
        )
        (br $label$3)
       )
       (set_local $9
        (i64.const 0)
       )
       (br_if $label$2
        (i64.le_u
         (get_local $7)
         (i64.const 11)
        )
       )
       (br $label$1)
      )
      (set_local $1
       (select
        (i32.add
         (get_local $1)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $1)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $9
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $1)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $9
     (i64.shl
      (i64.and
       (get_local $9)
       (i64.const 31)
      )
      (i64.and
       (get_local $6)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $5
    (i32.add
     (get_local $5)
     (i32.const 1)
    )
   )
   (set_local $7
    (i64.add
     (get_local $7)
     (i64.const 1)
    )
   )
   (set_local $8
    (i64.or
     (get_local $9)
     (get_local $8)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $6
      (i64.add
       (get_local $6)
       (i64.const -5)
      )
     )
     (i64.const -6)
    )
   )
  )
  (i32.store8 offset=32
   (get_local $10)
   (i32.const 9)
  )
  (i64.store offset=24
   (get_local $10)
   (get_local $8)
  )
  (i64.store
   (get_local $10)
   (i64.load
    (get_local $0)
   )
  )
  (call $assert
   (i32.eq
    (call $load_i64
     (i64.load offset=8
      (get_local $0)
     )
     (i64.const -3778506236080876544)
     (i64.const 7035937633859534848)
     (get_local $10)
     (i32.const 42)
    )
    (i32.const 42)
   )
   (i32.const 128)
  )
  (set_local $7
   (i64.const 0)
  )
  (set_local $6
   (i64.const 59)
  )
  (set_local $5
   (i32.const 32)
  )
  (set_local $2
   (i64.load offset=24
    (get_local $10)
   )
  )
  (set_local $8
   (i64.const 0)
  )
  (loop $label$6
   (block $label$7
    (block $label$8
     (block $label$9
      (block $label$10
       (block $label$11
        (br_if $label$11
         (i64.gt_u
          (get_local $7)
          (i64.const 3)
         )
        )
        (br_if $label$10
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $1
             (i32.load8_s
              (get_local $5)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $1
         (i32.add
          (get_local $1)
          (i32.const 165)
         )
        )
        (br $label$9)
       )
       (set_local $9
        (i64.const 0)
       )
       (br_if $label$8
        (i64.le_u
         (get_local $7)
         (i64.const 11)
        )
       )
       (br $label$7)
      )
      (set_local $1
       (select
        (i32.add
         (get_local $1)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $1)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $9
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $1)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $9
     (i64.shl
      (i64.and
       (get_local $9)
       (i64.const 31)
      )
      (i64.and
       (get_local $6)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $5
    (i32.add
     (get_local $5)
     (i32.const 1)
    )
   )
   (set_local $7
    (i64.add
     (get_local $7)
     (i64.const 1)
    )
   )
   (set_local $8
    (i64.or
     (get_local $9)
     (get_local $8)
    )
   )
   (br_if $label$6
    (i64.ne
     (tee_local $6
      (i64.add
       (get_local $6)
       (i64.const -5)
      )
     )
     (i64.const -6)
    )
   )
  )
  (call $assert
   (i64.eq
    (get_local $2)
    (get_local $8)
   )
   (i32.const 192)
  )
  (call $assert
   (i32.or
    (i64.eq
     (tee_local $7
      (i64.load
       (tee_local $5
        (i32.add
         (get_local $0)
         (i32.const 16)
        )
       )
      )
     )
     (i64.load offset=8
      (get_local $10)
     )
    )
    (i64.eq
     (get_local $7)
     (i64.load
      (get_local $10)
     )
    )
   )
   (i32.const 160)
  )
  (call $assert
   (i64.eq
    (i64.load
     (get_local $5)
    )
    (i64.load offset=16
     (get_local $10)
    )
   )
   (i32.const 224)
  )
  (set_local $1
   (i32.const 0)
  )
  (block $label$12
   (br_if $label$12
    (i32.ge_u
     (tee_local $3
      (i32.add
       (i32.mul
        (i32.load offset=24
         (get_local $0)
        )
        (i32.const 3)
       )
       (i32.load
        (tee_local $4
         (i32.add
          (get_local $0)
          (i32.const 28)
         )
        )
       )
      )
     )
     (i32.load8_u
      (i32.add
       (get_local $10)
       (i32.const 32)
      )
     )
    )
   )
   (set_local $1
    (i32.eqz
     (i32.load8_u
      (i32.add
       (i32.add
        (get_local $10)
        (get_local $3)
       )
       (i32.const 33)
      )
     )
    )
   )
  )
  (call $assert
   (get_local $1)
   (i32.const 256)
  )
  (i32.store8
   (i32.add
    (i32.add
     (get_local $10)
     (i32.add
      (i32.mul
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 24)
        )
       )
       (i32.const 3)
      )
      (i32.load
       (get_local $4)
      )
     )
    )
    (i32.const 33)
   )
   (select
    (i32.const 1)
    (i32.const 2)
    (tee_local $5
     (i64.eq
      (i64.load
       (get_local $5)
      )
      (tee_local $7
       (i64.load
        (i32.add
         (get_local $10)
         (i32.const 8)
        )
       )
      )
     )
    )
   )
  )
  (i64.store
   (i32.add
    (get_local $10)
    (i32.const 16)
   )
   (select
    (i64.load
     (get_local $10)
    )
    (get_local $7)
    (get_local $5)
   )
  )
  (i64.store
   (i32.add
    (get_local $10)
    (i32.const 24)
   )
   (call $_ZN11tic_tac_toe10get_winnerERKNS_4gameE
    (get_local $10)
   )
  )
  (drop
   (call $update_i64
    (get_local $7)
    (i64.const 7035937633859534848)
    (get_local $10)
    (i32.const 42)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $10)
    (i32.const 48)
   )
  )
 )
 (func $init
 )
 (func $apply (param $0 i64) (param $1 i64)
  (local $2 i32)
  (local $3 i32)
  (local $4 i64)
  (local $5 i64)
  (local $6 i64)
  (local $7 i64)
  (local $8 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $8
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (set_local $5
   (i64.const 0)
  )
  (set_local $4
   (i64.const 59)
  )
  (set_local $3
   (i32.const 288)
  )
  (set_local $6
   (i64.const 0)
  )
  (loop $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (block $label$4
       (block $label$5
        (br_if $label$5
         (i64.gt_u
          (get_local $5)
          (i64.const 10)
         )
        )
        (br_if $label$4
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $2
             (i32.load8_s
              (get_local $3)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $2
         (i32.add
          (get_local $2)
          (i32.const 165)
         )
        )
        (br $label$3)
       )
       (set_local $7
        (i64.const 0)
       )
       (br_if $label$2
        (i64.eq
         (get_local $5)
         (i64.const 11)
        )
       )
       (br $label$1)
      )
      (set_local $2
       (select
        (i32.add
         (get_local $2)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $2)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $7
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $2)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $7
     (i64.shl
      (i64.and
       (get_local $7)
       (i64.const 31)
      )
      (i64.and
       (get_local $4)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (set_local $4
    (i64.add
     (get_local $4)
     (i64.const -5)
    )
   )
   (set_local $6
    (i64.or
     (get_local $7)
     (get_local $6)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $5
      (i64.add
       (get_local $5)
       (i64.const 1)
      )
     )
     (i64.const 13)
    )
   )
  )
  (block $label$6
   (br_if $label$6
    (i64.ne
     (get_local $6)
     (get_local $0)
    )
   )
   (set_local $5
    (i64.const 0)
   )
   (set_local $4
    (i64.const 59)
   )
   (set_local $3
    (i32.const 304)
   )
   (set_local $6
    (i64.const 0)
   )
   (loop $label$7
    (block $label$8
     (block $label$9
      (block $label$10
       (block $label$11
        (block $label$12
         (br_if $label$12
          (i64.gt_u
           (get_local $5)
           (i64.const 5)
          )
         )
         (br_if $label$11
          (i32.gt_u
           (i32.and
            (i32.add
             (tee_local $2
              (i32.load8_s
               (get_local $3)
              )
             )
             (i32.const -97)
            )
            (i32.const 255)
           )
           (i32.const 25)
          )
         )
         (set_local $2
          (i32.add
           (get_local $2)
           (i32.const 165)
          )
         )
         (br $label$10)
        )
        (set_local $7
         (i64.const 0)
        )
        (br_if $label$9
         (i64.le_u
          (get_local $5)
          (i64.const 11)
         )
        )
        (br $label$8)
       )
       (set_local $2
        (select
         (i32.add
          (get_local $2)
          (i32.const 208)
         )
         (i32.const 0)
         (i32.lt_u
          (i32.and
           (i32.add
            (get_local $2)
            (i32.const -49)
           )
           (i32.const 255)
          )
          (i32.const 5)
         )
        )
       )
      )
      (set_local $7
       (i64.shr_s
        (i64.shl
         (i64.extend_u/i32
          (get_local $2)
         )
         (i64.const 56)
        )
        (i64.const 56)
       )
      )
     )
     (set_local $7
      (i64.shl
       (i64.and
        (get_local $7)
        (i64.const 31)
       )
       (i64.and
        (get_local $4)
        (i64.const 4294967295)
       )
      )
     )
    )
    (set_local $3
     (i32.add
      (get_local $3)
      (i32.const 1)
     )
    )
    (set_local $5
     (i64.add
      (get_local $5)
      (i64.const 1)
     )
    )
    (set_local $6
     (i64.or
      (get_local $7)
      (get_local $6)
     )
    )
    (br_if $label$7
     (i64.ne
      (tee_local $4
       (i64.add
        (get_local $4)
        (i64.const -5)
       )
      )
      (i64.const -6)
     )
    )
   )
   (block $label$13
    (br_if $label$13
     (i64.ne
      (get_local $6)
      (get_local $1)
     )
    )
    (call $assert
     (i32.gt_u
      (call $read_message
       (get_local $8)
       (i32.const 16)
      )
      (i32.const 15)
     )
     (i32.const 320)
    )
    (call $_ZN11tic_tac_toe12apply_createERKNS_6createE
     (get_local $8)
    )
    (br $label$6)
   )
   (set_local $5
    (i64.const 0)
   )
   (set_local $4
    (i64.const 59)
   )
   (set_local $3
    (i32.const 352)
   )
   (set_local $6
    (i64.const 0)
   )
   (loop $label$14
    (block $label$15
     (block $label$16
      (block $label$17
       (block $label$18
        (block $label$19
         (br_if $label$19
          (i64.gt_u
           (get_local $5)
           (i64.const 6)
          )
         )
         (br_if $label$18
          (i32.gt_u
           (i32.and
            (i32.add
             (tee_local $2
              (i32.load8_s
               (get_local $3)
              )
             )
             (i32.const -97)
            )
            (i32.const 255)
           )
           (i32.const 25)
          )
         )
         (set_local $2
          (i32.add
           (get_local $2)
           (i32.const 165)
          )
         )
         (br $label$17)
        )
        (set_local $7
         (i64.const 0)
        )
        (br_if $label$16
         (i64.le_u
          (get_local $5)
          (i64.const 11)
         )
        )
        (br $label$15)
       )
       (set_local $2
        (select
         (i32.add
          (get_local $2)
          (i32.const 208)
         )
         (i32.const 0)
         (i32.lt_u
          (i32.and
           (i32.add
            (get_local $2)
            (i32.const -49)
           )
           (i32.const 255)
          )
          (i32.const 5)
         )
        )
       )
      )
      (set_local $7
       (i64.shr_s
        (i64.shl
         (i64.extend_u/i32
          (get_local $2)
         )
         (i64.const 56)
        )
        (i64.const 56)
       )
      )
     )
     (set_local $7
      (i64.shl
       (i64.and
        (get_local $7)
        (i64.const 31)
       )
       (i64.and
        (get_local $4)
        (i64.const 4294967295)
       )
      )
     )
    )
    (set_local $3
     (i32.add
      (get_local $3)
      (i32.const 1)
     )
    )
    (set_local $5
     (i64.add
      (get_local $5)
      (i64.const 1)
     )
    )
    (set_local $6
     (i64.or
      (get_local $7)
      (get_local $6)
     )
    )
    (br_if $label$14
     (i64.ne
      (tee_local $4
       (i64.add
        (get_local $4)
        (i64.const -5)
       )
      )
      (i64.const -6)
     )
    )
   )
   (block $label$20
    (br_if $label$20
     (i64.ne
      (get_local $6)
      (get_local $1)
     )
    )
    (call $assert
     (i32.gt_u
      (call $read_message
       (get_local $8)
       (i32.const 24)
      )
      (i32.const 23)
     )
     (i32.const 320)
    )
    (call $_ZN11tic_tac_toe13apply_restartERKNS_7restartE
     (get_local $8)
    )
    (br $label$6)
   )
   (set_local $5
    (i64.const 0)
   )
   (set_local $4
    (i64.const 59)
   )
   (set_local $3
    (i32.const 368)
   )
   (set_local $6
    (i64.const 0)
   )
   (loop $label$21
    (block $label$22
     (block $label$23
      (block $label$24
       (block $label$25
        (block $label$26
         (br_if $label$26
          (i64.gt_u
           (get_local $5)
           (i64.const 4)
          )
         )
         (br_if $label$25
          (i32.gt_u
           (i32.and
            (i32.add
             (tee_local $2
              (i32.load8_s
               (get_local $3)
              )
             )
             (i32.const -97)
            )
            (i32.const 255)
           )
           (i32.const 25)
          )
         )
         (set_local $2
          (i32.add
           (get_local $2)
           (i32.const 165)
          )
         )
         (br $label$24)
        )
        (set_local $7
         (i64.const 0)
        )
        (br_if $label$23
         (i64.le_u
          (get_local $5)
          (i64.const 11)
         )
        )
        (br $label$22)
       )
       (set_local $2
        (select
         (i32.add
          (get_local $2)
          (i32.const 208)
         )
         (i32.const 0)
         (i32.lt_u
          (i32.and
           (i32.add
            (get_local $2)
            (i32.const -49)
           )
           (i32.const 255)
          )
          (i32.const 5)
         )
        )
       )
      )
      (set_local $7
       (i64.shr_s
        (i64.shl
         (i64.extend_u/i32
          (get_local $2)
         )
         (i64.const 56)
        )
        (i64.const 56)
       )
      )
     )
     (set_local $7
      (i64.shl
       (i64.and
        (get_local $7)
        (i64.const 31)
       )
       (i64.and
        (get_local $4)
        (i64.const 4294967295)
       )
      )
     )
    )
    (set_local $3
     (i32.add
      (get_local $3)
      (i32.const 1)
     )
    )
    (set_local $5
     (i64.add
      (get_local $5)
      (i64.const 1)
     )
    )
    (set_local $6
     (i64.or
      (get_local $7)
      (get_local $6)
     )
    )
    (br_if $label$21
     (i64.ne
      (tee_local $4
       (i64.add
        (get_local $4)
        (i64.const -5)
       )
      )
      (i64.const -6)
     )
    )
   )
   (block $label$27
    (br_if $label$27
     (i64.ne
      (get_local $6)
      (get_local $1)
     )
    )
    (call $assert
     (i32.gt_u
      (call $read_message
       (get_local $8)
       (i32.const 16)
      )
      (i32.const 15)
     )
     (i32.const 320)
    )
    (call $_ZN11tic_tac_toe11apply_closeERKNS_5closeE
     (get_local $8)
    )
    (br $label$6)
   )
   (set_local $5
    (i64.const 0)
   )
   (set_local $4
    (i64.const 59)
   )
   (set_local $3
    (i32.const 384)
   )
   (set_local $6
    (i64.const 0)
   )
   (loop $label$28
    (block $label$29
     (block $label$30
      (block $label$31
       (block $label$32
        (block $label$33
         (br_if $label$33
          (i64.gt_u
           (get_local $5)
           (i64.const 3)
          )
         )
         (br_if $label$32
          (i32.gt_u
           (i32.and
            (i32.add
             (tee_local $2
              (i32.load8_s
               (get_local $3)
              )
             )
             (i32.const -97)
            )
            (i32.const 255)
           )
           (i32.const 25)
          )
         )
         (set_local $2
          (i32.add
           (get_local $2)
           (i32.const 165)
          )
         )
         (br $label$31)
        )
        (set_local $7
         (i64.const 0)
        )
        (br_if $label$30
         (i64.le_u
          (get_local $5)
          (i64.const 11)
         )
        )
        (br $label$29)
       )
       (set_local $2
        (select
         (i32.add
          (get_local $2)
          (i32.const 208)
         )
         (i32.const 0)
         (i32.lt_u
          (i32.and
           (i32.add
            (get_local $2)
            (i32.const -49)
           )
           (i32.const 255)
          )
          (i32.const 5)
         )
        )
       )
      )
      (set_local $7
       (i64.shr_s
        (i64.shl
         (i64.extend_u/i32
          (get_local $2)
         )
         (i64.const 56)
        )
        (i64.const 56)
       )
      )
     )
     (set_local $7
      (i64.shl
       (i64.and
        (get_local $7)
        (i64.const 31)
       )
       (i64.and
        (get_local $4)
        (i64.const 4294967295)
       )
      )
     )
    )
    (set_local $3
     (i32.add
      (get_local $3)
      (i32.const 1)
     )
    )
    (set_local $5
     (i64.add
      (get_local $5)
      (i64.const 1)
     )
    )
    (set_local $6
     (i64.or
      (get_local $7)
      (get_local $6)
     )
    )
    (br_if $label$28
     (i64.ne
      (tee_local $4
       (i64.add
        (get_local $4)
        (i64.const -5)
       )
      )
      (i64.const -6)
     )
    )
   )
   (br_if $label$6
    (i64.ne
     (get_local $6)
     (get_local $1)
    )
   )
   (call $assert
    (i32.gt_u
     (call $read_message
      (get_local $8)
      (i32.const 32)
     )
     (i32.const 31)
    )
    (i32.const 320)
   )
   (call $_ZN11tic_tac_toe10apply_moveERKNS_4moveE
    (get_local $8)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 32)
   )
  )
 )
)
