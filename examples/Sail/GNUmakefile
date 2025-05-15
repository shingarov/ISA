all: ../Jib/riscv_quattropod.ir

../Jib/riscv_quattropod.ir: riscv_quattropod.sail
	sail --all-warnings --list-files --isla $<  -o ../Jib/riscv_quattropod

clean:
	rm ../Jib/riscv_quattropod.ir