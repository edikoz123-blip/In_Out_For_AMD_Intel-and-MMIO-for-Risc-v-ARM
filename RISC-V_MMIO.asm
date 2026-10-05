[64 bits]

; ==============================================================================
;          Created by The Ghost In The Matrix - RISC-V Hardware MMIO
; ==============================================================================

; 1. PRIVILEGE MODE CORRECTIONS & MACHINE-LEVEL CSRS (THE CORE PRIVILEGE GATEWAYS)
; ------------------------------------------------------------------------------
CSR_MSTATUS          equ 0x300   ; Machine Status Register (Controls interrupts, privilege levels)
CSR_MISA             equ 0x301   ; Machine ISA Architecture Register (Defines supported extensions)
CSR_MEDELEG          equ 0x302   ; Machine Exception Delegation Register (High-risk for privilege escalation)
CSR_MIDELEG          equ 0x303   ; Machine Interrupt Delegation Register (Routes hardware interrupts)
CSR_MIE              equ 0x304   ; Machine Interrupt Enable Register (R/W)
CSR_MTVEC            equ 0x305   ; Machine Trap-Vector Base-Address Register (Core exception trap vector)

; 2. MACHINE-LEVEL MEMORY PROTECTION (THE PHYSICAL MEMORY ISOLATION FOR MED-REGS)
; ------------------------------------------------------------------------------
; PMP (Physical Memory Protection) configurations used to lock hardware boundaries
CSR_PMPCFG0          equ 0x3A0   ; Physical Memory Protection Configuration Register 0 (R/W)
CSR_PMPADDR0         equ 0x3B0   ; Physical Memory Protection Address Register 0 (Lock matrix baseline)
CSR_PMPADDR1         equ 0x3B1   ; Physical Memory Protection Address Register 1

; Full 16-channel array for locking physical boundaries of medical devices
CSR_PMPCFG1          equ 0x3A1   ; PMP Configuration Register 1 (Channels 4-7)
CSR_PMPCFG2          equ 0x3A2   ; PMP Configuration Register 2 (Channels 8-11)
CSR_PMPCFG3          equ 0x3A3   ; PMP Configuration Register 3 (Channels 12-15)

CSR_PMPADDR2         equ 0x3B2   ; PMP Address Register 2 Matrix Gateway
CSR_PMPADDR3         equ 0x3B3   ; PMP Address Register 3 Matrix Gateway
CSR_PMPADDR4         equ 0x3B4   ; PMP Address Register 4
CSR_PMPADDR5         equ 0x3B5   ; PMP Address Register 5
CSR_PMPADDR6         equ 0x3B6   ; PMP Address Register 6
CSR_PMPADDR7         equ 0x3B7   ; PMP Address Register 7
CSR_PMPADDR8         equ 0x3B8   ; PMP Address Register 8
CSR_PMPADDR9         equ 0x3B9   ; PMP Address Register 9
CSR_PMPADDR10        equ 0x3BA   ; PMP Address Register 10
CSR_PMPADDR11        equ 0x3BB   ; PMP Address Register 11
CSR_PMPADDR12        equ 0x3BC   ; PMP Address Register 12
CSR_PMPADDR13        equ 0x3BD   ; PMP Address Register 13
CSR_PMPADDR14        equ 0x3BE   ; PMP Address Register 14
CSR_PMPADDR15        equ 0x3BF   ; PMP Address Register 15

; Extended hardware firewall for total isolation of multiple safety-critical cores
CSR_PMPCFG4          equ 0x3A4   ; PMP Configuration Register 4 (Channels 16-19)
CSR_PMPCFG5          equ 0x3A5   ; PMP Configuration Register 5 (Channels 20-23)
CSR_PMPCFG6          equ 0x3A6   ; PMP Configuration Register 6 (Channels 24-27)
CSR_PMPCFG7          equ 0x3A7   ; PMP Configuration Register 7 (Channels 28-31)

CSR_PMPADDR16        equ 0x3C0   ; PMP Address Register 16 Matrix Lock
CSR_PMPADDR17        equ 0x3C1   ; PMP Address Register 17
CSR_PMPADDR18        equ 0x3C2   ; PMP Address Register 18
CSR_PMPADDR19        equ 0x3C3   ; PMP Address Register 19
CSR_PMPADDR20        equ 0x3C4   ; PMP Address Register 20
CSR_PMPADDR21        equ 0x3C5   ; PMP Address Register 21
CSR_PMPADDR22        equ 0x3C6   ; PMP Address Register 22
CSR_PMPADDR23        equ 0x3C7   ; PMP Address Register 23
CSR_PMPADDR24        equ 0x3C8   ; PMP Address Register 24
CSR_PMPADDR25        equ 0x3C9   ; PMP Address Register 25
CSR_PMPADDR26        equ 0x3CA   ; PMP Address Register 26
CSR_PMPADDR27        equ 0x3CB   ; PMP Address Register 27
CSR_PMPADDR28        equ 0x3CC   ; PMP Address Register 28
CSR_PMPADDR29        equ 0x3CD   ; PMP Address Register 29
CSR_PMPADDR30        equ 0x3CE   ; PMP Address Register 30
CSR_PMPADDR31        equ 0x3CF   ; PMP Address Register 31

; 3. HYPERVISOR EXTENSION CONTROL CSRS (THE EMBEDDED VIRTUALIZATION MATRIX)
; ------------------------------------------------------------------------------
CSR_HSTATUS          equ 0x600   ; Hypervisor Status Register (Tracks guest mode execution and isolation)
CSR_HEDELEG          equ 0x602   ; Hypervisor Exception Delegation Register (Delegates traps to VS-mode)
CSR_HIDELEG          equ 0x603   ; Hypervisor Interrupt Delegation Register
CSR_HGATP            equ 0x680   ; Hypervisor Guest Address Translation and Protection (Second-level Page Tables)

CSR_MISELECT         equ 0x350   ; Machine Interrupt Select Register (AIA Core)
CSR_MIREG            equ 0x351   ; Machine Interrupt Register Window (R/W)
CSR_MTOPI            equ 0xFB0   ; Machine Top-of-Interrupt Register (AIA hardware routing)

; 4. MACHINE-LEVEL TRAP HANDLING & EXCEPTION LOGGING (CORE FORENSICS)
; ------------------------------------------------------------------------------
CSR_MSCRATCH         equ 0x340   ; Machine Scratch Register (Dedicated for context saving)
CSR_MEPC             equ 0x0341  ; Machine Exception Program Counter (Holds faulting instruction address)
CSR_MCAUSE           equ 0x342   ; Machine Cause Register (Identifies trap cause vector)
CSR_MTVAL            equ 0x343   ; Machine Trap Value Register (Holds bad address or instruction payload)
CSR_MIP              equ 0x344   ; Machine Interrupt Pending Register (R/W)

; 5. VIRTUAL SUPERVISOR EXTENSION CSRS (SHADOW EXECUTION MATRIX)
; ------------------------------------------------------------------------------
CSR_VSSTATUS         equ 0x200   ; Virtual Supervisor Status Register (Guest core configuration)
CSR_VSIE             equ 0x204   ; Virtual Supervisor Interrupt Enable Register (R/W)
CSR_VSTVEC           equ 0x205   ; Virtual Supervisor Trap-Vector Base-Address Register
CSR_VSSCRATCH        equ 0x240   ; Virtual Supervisor Scratch Register Configuration
CSR_VSEPC            equ 0x241   ; Virtual Supervisor Exception Program Counter
CSR_VSCAUSE          equ 0x242   ; Virtual Supervisor Cause Register Allocation
CSR_VSTVAL           equ 0x243   ; Virtual Supervisor Trap Value Payload Matrix
CSR_VSIP             equ 0x244   ; Virtual Supervisor Interrupt Pending Register

; 6. HARDWARE TRIGGER & HARDENING DEBUG MODULE (ANTI-SNIFFING HARDWARE LOCK)
; ------------------------------------------------------------------------------
CSR_TSELECT          equ 0x7A0   ; Trigger Select Register (Hardware breakpoint allocation)
CSR_TDATA1           equ 0x7A1   ; Trigger Data 1 (Defines hardware intercept conditions)
CSR_TDATA2           equ 0x7A2   ; Trigger Data 2 (Holds target address payload matrix)
CSR_TDATA3           equ 0x7A3   ; Trigger Data 3 (Extended execution monitoring)

; 7. MACHINE PERFORMANCE COUNTERS & TIME-KEEPING VECTOR
; ------------------------------------------------------------------------------
CSR_MCYCLE           equ 0xB00   ; Machine Cycle Counter Register (Low 32-bits/64-bits execution core)
CSR_MINSTRET         equ 0xB02   ; Machine Instructions Retired Counter (Anomalous pattern detection)

; High-resolution arrays used for side-channel attack mitigation and tracing
CSR_MHPMCOUNTER3     equ 0xB03   ; Machine Hardware Performance Counter 3
CSR_MHPMCOUNTER4     equ 0xB04   ; Machine Hardware Performance Counter 4
CSR_MHPMCOUNTER5     equ 0xB05   ; Machine Hardware Performance Counter 5
CSR_MHPMCOUNTER6     equ 0xB06   ; Machine Hardware Performance Counter 6
CSR_MHPMCOUNTER7     equ 0xB07   ; Machine Hardware Performance Counter 7

CSR_MHPMEVENT3       equ 0x323   ; Machine Hardware Performance Event 3
CSR_MHPMEVENT4       equ 0x324   ; Machine Hardware Performance Event 4
CSR_MHPMEVENT5       equ 0x325   ; Machine Hardware Performance Event 5
CSR_MHPMEVENT6       equ 0x326   ; Machine Hardware Performance Event 6
CSR_MHPMEVENT7       equ 0x327   ; Machine Hardware Performance Event 7

CSR_MHPMCOUNTER8     equ 0xB08   ; Machine Hardware Performance Counter 8
CSR_MHPMCOUNTER9     equ 0xB09   ; Machine Hardware Performance Counter 9
CSR_MHPMEVENT8       equ 0x328   ; Machine Hardware Performance Event 8
CSR_MHPMEVENT9       equ 0x329   ; Machine Hardware Performance Event 9

; ==============================================================================
; 8. RISC-V VENDOR-SPECIFIC & CUSTOM EXTENSION CSRS (NON-STANDARD SILICON LOCK)
; ------------------------------------------------------------------------------
; Enforcing Absolute Default Deny rules over the undocumented manufacturer space
CSR_CUSTOM_S_ZONE0   equ 0x5C0   ; Custom Supervisor Configuration Register Baseline
CSR_CUSTOM_M_ZONE0   equ 0x7C0   ; Custom Machine-Mode Hardware Core Controller 0
CSR_CUSTOM_M_ZONE1   equ 0x7C1   ; Custom Machine-Mode Hardware Execution Delay / Lock
CSR_CUSTOM_M_SECURE  equ 0x7FF   ; Manufacturer Deep Firmware Cryptographic Gateway
