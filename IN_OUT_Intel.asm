[64 bits]

;==============================================================================
;					Created by The Ghost In The Matrix
;==============================================================================

; ==============================================================================
; 1. SYSTEM CONTROL, RESET & POWER MANAGEMENT (HIGH RISK FOR HV ESCAPE)
; ==============================================================================
PORT_KBC_DATA        equ 0x0060  ; Keyboard Controller / A20 Gate Data (R/W)
PORT_SYS_CTRL_B      equ 0x0061  ; System Control B / PC Speaker & NMI Flags (R/W)
PORT_KBC_COMMAND     equ 0x0064  ; Keyboard Controller Command/Status Register (R/W)
PORT_SYS_CTRL_A      equ 0x0092  ; System Control A / Fast Init & Fast A20 (R/W)
APM_CNT_SMI          equ 0x00B2  ; APM Control / SMI Trigger Port (System Management Mode)
APM_STS_SMI          equ 0x00B3  ; APM Status Port (R/W)
RST_CNT_PORT         equ 0x0CF9  ; Reset Control Register (0x06=Hard, 0x0E=Full Cycle)

; ACPI Power Management Block Base Offsets (Configure via PCI Base Addresses)
PM_STS_OFFSET        equ 0x00    ; PM1 Status Register (Clear Power Events)
PM_CNT_OFFSET        equ 0x04    ; PM1 Control Register (Sleep, Suspend, Shutdown)
PM_TMR_OFFSET        equ 0x08    ; PM1 Timer Register (24-bit System Timer)

; ==============================================================================
; 2. PCI CONFIGURATION & CHIPSET INTERCONNECTS
; ==============================================================================
PCI_CONFIG_ADDRESS   equ 0x0CF8  ; PCI Configuration Space Index Register (32-bit Address)
PCI_CONFIG_DATA      equ 0x0CFC  ; PCI Configuration Space Data Window (32-bit Data Access)

; Super I/O and Embedded Controller Configuration Gateways
PORT_SIO_INDEX_1     equ 0x002E  ; Super I/O Configuration Index Port A (R/W)
PORT_SIO_DATA_1      equ 0x002F  ; Super I/O Configuration Data Port A (R/W)
PORT_SIO_INDEX_2     equ 0x004E  ; Super I/O / LPC Configuration Index Port B (R/W)
PORT_SIO_DATA_2      equ 0x004F  ; Super I/O / LPC Configuration Data Port B (R/W)

; SBI (Sideband Interface) Internal Chipset Routing
SBI_ADDR_PORT        equ 0x0D00  ; Sideband Private Configuration Address (R/W)
SBI_DATA_PORT        equ 0x0D04  ; Sideband Private Configuration Data (R/W)

; ==============================================================================
; 3. INTERRUPT CONTROLLERS (PIC 8259A & APIC INTERFACE)
; ==============================================================================
PORT_PIC1_CMD        equ 0x0020  ; Master PIC Command/Status Register (R/W)
PORT_PIC1_DATA       equ 0x0021  ; Master PIC Interrupt Mask/Data Register (R/W)
PORT_PIC1_ALIAS_LOW  equ 0x0024  ; Master PIC Alternate Alias Port
PORT_PIC2_CMD        equ 0x00A0  ; Slave PIC Command/Status Register (R/W)
PORT_PIC2_DATA       equ 0x00A1  ; Slave PIC Interrupt Mask/Data Register (R/W)
PORT_PIC2_ALIAS_LOW  equ 0x00A4  ; Slave PIC Alternate Alias Port

PORT_APIC_INDEX      equ 0x0022  ; APIC Chipset Index Port (Write-Only)
PORT_APIC_DATA       equ 0x0023  ; APIC Chipset Data Port (R/W)

PORT_ELCR1           equ 0x04D0  ; PCH Master IRQ Edge/Level Selector (R/W)
PORT_ELCR2           equ 0x04D1  ; PCH Slave IRQ Edge/Level Selector (R/W)

; ==============================================================================
; 4. TIMERS, TIME-KEEPING, & CMOS RECOVERY
; ==============================================================================
PORT_PIT_COUNTER0    equ 0x0040  ; Programmable Interval Timer Channel 0 (System Clock)
PORT_PIT_COUNTER1    equ 0x0041  ; PIT Channel 1 (Refresh Controller - Legacy)
PORT_PIT_COUNTER2    equ 0x0042  ; PIT Channel 2 (PC Speaker Frequency Direct Control)
PORT_PIT_COMMAND     equ 0x0043  ; PIT Command Register (Write-Only)

PORT_CMOS_ADDRESS    equ 0x0070  ; CMOS Index Register & NMI Mask Bit (Write-Only)
PORT_CMOS_DATA       equ 0x0071  ; CMOS Data Register (R/W)
CMOS_EXT_ADDRESS     equ 0x0072  ; Extended CMOS Index Register (R/W)
CMOS_EXT_DATA        equ 0x0073  ; Extended CMOS Data Register (R/W)

; ==============================================================================
; 5. SYSTEM DMA CONTROLLERS (8237A DRIVERS) & PAGE REGISTERS
; ==============================================================================
; DMA Controller 1 (Channels 0-3)
DMA1_CH0_ADDR        equ 0x0000  ; Channel 0 Base Address (R/W)
DMA1_CH0_COUNT       equ 0x0001  ; Channel 0 Word Count (R/W)
DMA1_CH1_ADDR        equ 0x0002  ; Channel 1 Base Address (R/W)
DMA1_CH1_COUNT       equ 0x0003  ; Channel 1 Word Count (R/W)
DMA1_CH2_ADDR        equ 0x0004  ; Channel 2 Base Address (R/W)
DMA1_CH2_COUNT       equ 0x0005  ; Channel 2 Word Count (R/W)
DMA1_CH3_ADDR        equ 0x0006  ; Channel 3 Base Address (R/W)
DMA1_CH3_COUNT       equ 0x0007  ; Channel 3 Word Count (R/W)
DMA1_STATUS_REG      equ 0x0008  ; Status (R) / Command (W) Register
DMA1_REQ_REG         equ 0x0009  ; Request Register (W)
DMA1_SINGLE_MASK     equ 0x000A  ; Single Mask Bit Register (W)
DMA1_MODE_REG        equ 0x000B  ; Mode Register (W)
DMA1_CLEAR_FLIPFLOP  equ 0x000C  ; Clear Byte Pointer Flip-Flop (W)
DMA1_TEMP_REG        equ 0x000D  ; Master Clear (W) / Temporary Register (R)
DMA1_CLEAR_MASK      equ 0x000E  ; Clear Mask Register (W)
DMA1_MASK_REG        equ 0x000F  ; All Mask Bits Register (R/W)

; DMA Controller 2 (Channels 4-7)
DMA2_CH4_ADDR        equ 0x00C0  ; Channel 4 Base Address (R/W)
DMA2_CH4_COUNT       equ 0x00C1  ; Channel 4 Word Count (R/W)
DMA2_CH5_ADDR        equ 0x00C2  ; Channel 5 Base Address (R/W)
DMA2_CH5_COUNT       equ 0x00C3  ; Channel 5 Word Count (R/W)
DMA2_CH6_ADDR        equ 0x00C4  ; Channel 6 Base Address (R/W)
DMA2_CH6_COUNT       equ 0x00C5  ; Channel 6 Word Count (R/W)
DMA2_CH7_ADDR        equ 0x00C6  ; Channel 7 Base Address (R/W)
DMA2_CH7_COUNT       equ 0x00C7  ; Channel 7 Word Count (R/W)
DMA2_STATUS_REG      equ 0x00D0  ; Status (R) / Command (W) Register
DMA2_REQ_REG         equ 0x00D2  ; Request Register (W)
DMA2_SINGLE_MASK     equ 0x00D4  ; Single Mask Bit Register (W)
DMA2_MODE_REG        equ 0x00D6  ; Mode Register (W)
DMA2_CLEAR_FLIPFLOP  equ 0x00D8  ; Clear Byte Pointer Flip-Flop (W)
DMA2_TEMP_REG        equ 0x00DA  ; Master Clear (W) / Temporary Register (R)
DMA2_CLEAR_MASK      equ 0x00DC  ; Clear Mask Register (W)
DMA2_MASK_REG        equ 0x00DE  ; All Mask Bits Register (R/W)

; DMA Page Registers (Address Boundaries for Transactions)
PORT_DMA_PAGE_CH0    equ 0x0087  ; DMA Channel 0 Page Register (R/W)
PORT_DMA_PAGE_CH1    equ 0x0083  ; DMA Channel 1 Page Register (R/W)
PORT_DMA_PAGE_CH2    equ 0x0081  ; DMA Channel 2 Page Register (R/W)
PORT_DMA_PAGE_CH3    equ 0x0082  ; DMA Channel 3 Page Register (R/W)
PORT_DMA_PAGE_CH5    equ 0x008B  ; DMA Channel 5 Page Register (R/W)
PORT_DMA_PAGE_CH6    equ 0x008C  ; DMA Channel 6 Page Register (R/W)
PORT_DMA_PAGE_CH7    equ 0x008D  ; DMA Channel 7 Page Register (R/W)
PORT_DMA_REFRESH     equ 0x008F  ; Refresh Page Register (R/W)

; ==============================================================================
; 6. MOTHERBOARD GRAPHICS (VGA) & DEBUG CODES
; ==============================================================================
PORT_80H_POST        equ 0x0080  ; Diagnostics & Motherboard POST Delay Port (R/W)

; VGA Attribute, Sequencer and External Registers
PORT_VGA_MISC_READ   equ 0x03CC  ; VGA Miscellaneous Output Register (Read)
PORT_VGA_MISC_WRITE  equ 0x03C2  ; VGA Miscellaneous Output Register (Write)
PORT_VGA_FEATURE_R   equ 0x03CA  ; VGA Feature Control Register (Read)
PORT_VGA_FEATURE_W   equ 0x03DA  ; VGA Feature Control Register (Write - Color Alias)
PORT_VGA_SEQ_INDEX   equ 0x03C4  ; VGA Sequencer Index Register (R/W)
PORT_VGA_SEQ_DATA    equ 0x03C5  ; VGA Sequencer Data Register (R/W)
PORT_VGA_DAC_MASK    equ 0x03C6  ; VGA DAC Pel Mask Register (R/W)
PORT_VGA_DAC_READ_IS equ 0x03C7  ; VGA DAC State/Read Index Register (R/W)
PORT_VGA_DAC_WRITE_I equ 0x03C8  ; VGA DAC Write Index Register (R/W)
PORT_VGA_DAC_DATA    equ 0x03C9  ; VGA DAC Data Register (R/W)
PORT_VGA_ATT_INDEX   equ 0x03C0  ; VGA Attribute Controller Index/Data Register (R/W)
PORT_VGA_ATT_READ    equ 0x03C1  ; VGA Attribute Controller Read Register

; VGA CRT Controller Mappings (Color vs Monochrome Emulation Layouts)
PORT_VGA_CRTC_INDEX  equ 0x03D4  ; VGA CRT Controller Index - Color Mode (R/W)
PORT_VGA_CRTC_DATA   equ 0x03D5  ; VGA CRT Controller Data Window - Color Mode (R/W)
PORT_VGA_STATUS_1    equ 0x03DA  ; VGA Input Status Register 1 - Color Mode (R)

PORT_VGA_MONO_CRTC_I equ 0x03B4  ; VGA CRT Controller Index - Monochrome Mode (R/W)
PORT_VGA_MONO_CRTC_D equ 0x03B5  ; VGA CRT Controller Data Window - Monochrome Mode (R/W)
PORT_VGA_MONO_STAT_1 equ 0x03BA  ; VGA Input Status Register 1 - Monochrome Mode (R)

; VGA Graphics Controller Block
PORT_VGA_GFX_INDEX   equ 0x03CE  ; VGA Graphics Controller Index (R/W)
PORT_VGA_GFX_DATA    equ 0x03CF  ; VGA Graphics Controller Data (R/W)

; ==============================================================================
; 7. LEGACY STORAGE, PERIPHERALS, AND COMMUNICATION (CHIPSET EMULATED)
; ==============================================================================
COM1_PORT            equ 0x03F8  ; UART COM1 Base Port (Primary Serial/Kernel Debug)
COM2_PORT            equ 0x02F8  ; UART COM2 Base Port (Secondary Serial Interface)
COM3_PORT            equ 0x03E8  ; UART COM3 Base Port (R/W)
COM4_PORT            equ 0x02E8  ; UART COM4 Base Port (R/W)

PORT_LPT1_DATA       equ 0x0378  ; Legacy Parallel Port LPT1 Data (R/W)
PORT_LPT1_STATUS     equ 0x0379  ; Legacy Parallel Port LPT1 Status (R)
PORT_LPT1_CONTROL    equ 0x037A  ; Legacy Parallel Port LPT1 Control (R/W)
PORT_LPT2_DATA       equ 0x0278  ; Secondary Parallel Port LPT2 Data (R/W)

PORT_LPT2_STATUS equ 0x0279 ; Secondary Parallel Port LPT2 Status (R)
PORT_LPT2_CONTROL equ 0x027A ; Secondary Parallel Port LPT2 Control (R/W)
ATA_PRI_DATA equ 0x01F0 ; Primary Storage Channel Data Register (R/W)
ATA_PRI_COMMAND equ 0x01F7 ; Primary Storage Channel Command/Status Register
ATA_SEC_DATA equ 0x0170 ; Secondary Storage Channel Data Register (R/W)
ATA_SEC_COMMAND equ 0x0177 ; Secondary Storage Channel Command/Status Register
ATA_TER_DATA equ 0x01E8 ; Tertiary Storage Channel Data Register (R/W)
ATA_TER_COMMAND equ 0x01EF ; Tertiary Storage Channel Command/Status Register
ATA_QUA_DATA equ 0x0168 ; Quaternary Storage Channel Data Register (R/W)
ATA_QUA_COMMAND equ 0x016F ; Quaternary Storage Channel Command/Status Register
FDC_DIG_OUTPUT equ 0x03F2 ; Floppy Disk Controller Digital Output (R/W)
FDC_MAIN_STATUS equ 0x03F4 ; Floppy Disk Controller Main Status Register (R)
FDC_DATA_FIFO equ 0x03F5 ; Floppy Disk Controller Data FIFO Register (R/W)
FDC_DIG_INPUT equ 0x03F7 ; Floppy Disk Controller Digital Input Register (R)
; ==============================================================================
; 8. INTEL CHIPSET SPECIFIC ENHANCEMENTS & SECURITY ENGINES
; ==============================================================================
INTEL_ME_HECI_BASE equ 0x0C50 ; Intel Management Engine HECI Interface Port (R/W)
PORT_INTEL_CLK_CNT equ 0x00B0 ; Intel PCH Clock Gating Control Window (R/W)
PORT_FPU_CLEAR equ 0x00F0 ; Processor Coprocessor FERR# Error Reset Window
PORT_CHIPSET_DELAY equ 0x0240 ; Intel Internal Hardware Execution Delay Port
PORT_GAMEPORT_LOW equ 0x0200 ; Legacy Gameport Joystick Status Window (R/W)
PORT_GAMEPORT_HIGH equ 0x0208 ; Legacy Gameport Upper Control Block (R/W)