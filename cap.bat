@echo off
net use lpt1 /delete
net use lpt2 /delete
net use lpt3 /delete
net use lpt1 \\10.0.0.99\p1 /persistent:yes
net use lpt2 \\10.0.0.99\p1 /persistent:yes
net use lpt3 \\10.0.0.99\p1 /persistent:yes

