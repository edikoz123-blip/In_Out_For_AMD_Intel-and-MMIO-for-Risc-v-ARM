[64 bits] 
; ==============================================================================
;					Created by The Ghost In The Matrix
; ==============================================================================

; ==============================================================================
;          🏛️ AMD AM5 CHIPSET IDENTITY & HARDWARE I/O GATEWAYS 🏛️
; ==============================================================================
; FILE: amd_chipset_io_def.inc
; AUTHOR: The Ghost In The Matrix
; PURPOSE: Pure AMD Read-Only coordinates and I/O ports for hardware locks.
; PHILOSOPHY: AMD-Exclusive, Static Dictatorship, Pure I/O (NO MSRs).
; ==============================================================================


; ==============================================================================
; 🔌 INTERFACE BLOCK: UNIVERSAL x86 HARDWARE I/O GATEWAY PORTS
; ------------------------------------------------------------------------------
; EXPLANATION: These two ports bypass physical RAM entirely and map directly 
; to the motherboards copper traces connecting to the PCI Configuration Space.
; Anyone who controls these two gateways commands the absolute hardware state.
; ==============================================================================

%define AMD_PCI_CONFIG_ADDR_PORT        0x0CF8  
; [READ/WRITE] The "Targeting Scope". Injects the exact 32-bit geometric 
; coordinate (Bus, Device, Function, Offset) into the motherboard routing engine.

%define AMD_PCI_CONFIG_DATA_PORT        0x0CFC  
; [READ/WRITE] The "Execution Trigger". Acts as a bidirectional data window. 
; Forces the hardware to either return passive data (IN) or alter transistors (OUT).


; ==============================================================================
; 🛰️ VERIFICATION BLOCK: HARDWIRED AMD SILICON IDENTIFIERS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Used to enforce architectural sovereignty and verify the platform.
; These values are hardwired at manufacture and cannot be altered or spoofed.
; ==============================================================================

%define AMD_UNIVERSAL_HOST_BRIDGE       0x80000000 
; [READ-ONLY] Geometric absolute address of Bus 0, Device 0, Function 0, Offset 0x00.
; Points the radar directly to the physical Host/Northbridge embedded in the chip.

%define AMD_FUSED_VENDOR_ID             0x1022     
; [READ-ONLY] The unchangeable silicon signature laser-fused by AMD at the factory.
; If a query to the Host Bridge does not return this ID, a hostile platform is assumed.


; ==============================================================================
; 🏎️ DECODING BLOCK: AMD CHIPSET GENERATION CODENAMES (DEVICE IDs IN UPPER 16-BITS)
; ------------------------------------------------------------------------------
; EXPLANATION: Architectural radar markers used to read device metadata.
; By shifting the 32-bit response right by 16 bits, the SMM code dynamically
; identifies the exact socket layout, generation, and capabilities of the platform.
; ==============================================================================

%define AMD_CHIPSET_ZEN4_X670E          0x14D8     
; [READ-ONLY] Fused hardware signature for the High-End AMD Zen 4 Enthusiast Chipset.

%define AMD_CHIPSET_ZEN4_B650           0x14E8     
; [READ-ONLY] Fused hardware signature for the Mainstream AMD Zen 4 Platform Chipset.

%define AMD_CHIPSET_ZEN5_X870E          0x163A     
; [READ-ONLY] Fused hardware signature for the Flagship AMD Zen 5 Extreme Performance Chipset.

%define AMD_CHIPSET_ZEN5_B850           0x164A     
; [READ-ONLY] Fused hardware signature for the Mainstream AMD Zen 5 Platform Chipset.

; ==============================================================================
; 🔐 LOCKDOWN BLOCK: AMD FCH LPC/eSPI HARDWARE LOCKS (RING -2 INTERCEPT)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware controller that routes access to the 
; motherboards SPI Flash Memory (where the system BIOS/Firmware resides).
; Writing to this configuration bridge seals the permanent platform firmware cage.
; ==============================================================================

%define AMD_FCH_LPC_BRIDGE_BASE         0x8000F800 
; [READ-ONLY] Geometric absolute address mapping Bus 0, Device 31, Function 0.
; Routes the hardware radar directly to the AMD Fusion Controller Hub (FCH / Southbridge).

%define AMD_LPC_REG_SPI_ROM_PROTECT     0x000000DC 
; [READ/WRITE] The exact register offset inside the LPC Bridge handling firmware safety.
; Actively combined with the physical target address to open the hardware locking gate.


; ==============================================================================
; 🛡️ PAYLOAD BLOCK: AMD SECURITY BITMASK FOR BIOS & FIRMWARE PROTECTION
; ------------------------------------------------------------------------------
; EXPLANATION: Atomic bitmask configuration applied to Offset 0xDC via port 0x0CFC.
; Fusing these specific bits changes the physical logic gates of the motherboard, 
; stripping all runtime code (even Ring -1 / Hypervisor) of firmware modification rights.
; ==============================================================================

%define AMD_CHIPSET_LOCK_MASK           0x00000023 
; [STICKY BITS - WRITE ONCE] The combined electrical execution payload.
; Constructed by atomically fusing three critical microarchitectural bits:
;
;   • BIT 0 (0x01): BIOS_WP -> BIOS Write Protect. Hardware-enforced freeze 
;     on the SPI Flash memory lines. Blocks unauthorized physical rewrites.
;
;   • BIT 1 (0x02): BLE -> BIOS Lock Enable. Fuses the configuration state. 
;     Permanently locks the BIOS_WP bit from being cleared or flipped back to 0.
;
;   • BIT 5 (0x20): SMM_BWP -> SMM BIOS Write Protect. Forces the physical 
;     motherboard flash interface to only accept updates verified within Ring -2 (SMM).
;
; CRITICAL SILICON BEHAVIOR: Once an 'OUT' command injects this mask into port 0x0CFC, 
; the hardware activates a sticky lock latch. The register instantly drops all write 
; capabilities and turns into a hardwired [READ-ONLY] state until a complete physical power cycle.

; ==============================================================================
; 🔐 CATEGORY 2: AMD SECURITY & SUBSYSTEM RADAR COORDINATES (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Mapped directly to the core security engines and system fabrics.
; These coordinates target unchangeable silicon controllers that report the 
; systems physical isolation, cryptographic, and peripheral routing baselines.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD PLATFORM SECURITY PROCESSOR (PSP GATEWAY) ---
; EXPLANATION: The PSP is a dedicated, secure ARM-based co-processor embedded 
; inside the AMD die. It serves as the physical hardware root of trust, managing 
; firmware authentication (fTPM) and hardware encryption enforcement engines.
; ------------------------------------------------------------------------------
%define AMD_PSP_RADAR_COORDINATE        0x80004100 
; [READ-ONLY] Geometric absolute address targeting Bus 0, Device 8, Function 1.
; Points the radar to the front door of the main platform encryption system.

%define AMD_PSP_REG_STATUS_OFFSET       0x10       
; [READ-ONLY] Hardware Cryptographic Status Register offset. Sniffs whether 
; hardware encryption fuses and pre-boot platform trust anchors are active.


; --- SUBSYSTEM CODENAME: AMD-Vi IOMMU FRAMEWORK (MEMORY ISOLATION CONTROL) ---
; EXPLANATION: The IOMMU controls and translates physical memory access (DMA) 
; requested by peripheral devices (like GPUs and NICs). It acts as a hardware 
; firewall, stopping external devices from modifying critical system memory zones.
; ------------------------------------------------------------------------------
%define AMD_IOMMU_RADAR_COORDINATE      0x80000400 
; [READ-ONLY] Geometric absolute address targeting Bus 0, Device 0, Function 2.
; Points the radar directly to the physical silicon I/O Memory Management Unit.

%define AMD_IOMMU_CAP_REG_OFFSET        0x44       
; [READ-ONLY] Architectural Capabilities Mask register offset. Discloses the 
; exact hardware capabilities, routing structures, and page table formats.


; --- SUBSYSTEM CODENAME: AMD SMBus CONTROLLER (PERIPHERAL BUS METRICS) ---
; EXPLANATION: System Management Bus (SMBus). A low-speed, two-wire hardware bus 
; used for passive motherboard auditing. It reads continuous telemetry from 
; physical RAM sticks (SPD) and monitoring chips without interfering with code execution.
; ------------------------------------------------------------------------------
%define AMD_SMBUS_RADAR_COORDINATE      0x8000F810 
; [READ-ONLY] Geometric absolute address targeting Bus 0, Device 31, Function 2.
; Points the radar to the motherboard intelligence and environmental telemetry data.


; ==============================================================================
; 💾 CATEGORY 3: AMD STORAGE CONTROLLERS & CORE BRIDGES (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the high-speed data lanes and structural silicon bridges.
; These coordinates allow the SMM code to passive-scan and audit the physical 
; storage architecture and PCIe topologies to ensure no DMA bypass leaks exist.
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD PRIMARY NVMe ARCHITECTURE ---
; EXPLANATION: The physical storage engine mapping the ultra-fast M.2 NVMe SSD 
; lines connected directly to the CPU. Crucial for auditing low-level disk I/O.
; ------------------------------------------------------------------------------
%define AMD_CORE_NVME_COORDINATE        0x80000A00 
; [READ-ONLY] Geometric absolute address targeting Bus 0, Device 1, Function 2.
; Points the radar to the primary high-speed AM5 solid-state storage interface.

%define AMD_REG_PCI_HEADER_TYPE         0x0E       
; [READ-ONLY] Architectural Header Type layout register. Fused byte verifying 
; if the device is a single-function layout, multi-function, or a bridge structure.


; --- SUBSYSTEM CODENAME: AMD PHYSICAL SATA CONTROLLER ---
; EXPLANATION: Legacy/Secondary storage hardware array handling legacy hard drives 
; and external solid-state storage controllers fused into the AMD Southbridge.
; ------------------------------------------------------------------------------
%define AMD_FCH_SATA_COORDINATE         0x8000F818 
; [READ-ONLY] Geometric absolute address targeting Bus 0, Device 31, Function 3.
; Points the radar directly to the physical AMD FCH Advanced Host Controller Interface (AHCI).


; --- SUBSYSTEM CODENAME: AMD HIGH-SPEED PCIe ROOT PORT 0 ---
; EXPLANATION: The primary architectural silicon lane routing direct high-bandwidth 
; connection to the main discrete graphics card (GPU) or external acceleration hardware.
; ------------------------------------------------------------------------------
%define AMD_PCIE_ROOT_PORT_0            0x80000800 
; [READ-ONLY] Geometric absolute address targeting Bus 0, Device 1, Function 0.
; Points the radar to the physical PCIe Gen 5 Graphics core attachment matrix.


; --- SUBSYSTEM CODENAME: AMD HIGH-SPEED PCIe ROOT PORT 1 ---
; EXPLANATION: Secondary hardware link utilized to map high-speed auxiliary storage 
; expansion boards or alternative high-frequency interface cards.
; ------------------------------------------------------------------------------
%define AMD_PCIE_ROOT_PORT_1            0x80000C00 
; [READ-ONLY] Geometric absolute address targeting Bus 0, Device 1, Function 4.
; Points the radar to the secondary hardware-fused PCIe storage routing framework.

; ==============================================================================
; ⏱️ CATEGORY 4: AMD INTERRUPT & TIMER CONTROLLERS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Configures coordinates for structural timekeepers and signal routing.
; These parameters allow SMM software to passively inspect clock drift, audit 
; high-frequency hardware events, and monitor raw system interrupt layouts.
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD HIGH-PRECISION EVENT TIMER (HPET CONTROLLER) ---
; EXPLANATION: The foundational silicon clock architecture on the motherboard. 
; Used to track highly precise micro-gaps in time to spot timing channel attacks.
; ------------------------------------------------------------------------------
%define AMD_FCH_HPET_COORDINATE         0x8000F800 
; [READ-ONLY] Geometric absolute address targeting Bus 0, Device 31, Function 0.
; Aligns the radar to the main LPC/eSPI interface hosting the HPET configuration register.

%define AMD_REG_HPET_DECODE_EN          0x44       
; [READ-ONLY] High-Precision Event Timer Decode Enable register. Fused mask 
; showing if the physical HPET memory window is properly exposed to the topology.


; --- SUBSYSTEM CODENAME: AMD I/O ADVANCED PROGRAMMABLE INTERRUPT CONTROLLER ---
; EXPLANATION: The physical motherboard bridge routing electric interrupt signals 
; from external hardware devices (mouses, drives) directly into the CPU cores.
; ------------------------------------------------------------------------------
%define AMD_IOAPIC_RADAR_COORDINATE     0x8000F800 
; [READ-ONLY] Geometric absolute address targeting Bus 0, Device 31, Function 0.
; Shared FCH routing anchor used to isolate interrupt configuration matrices.

%define AMD_REG_IOAPIC_BASE_ADDR        0x74       
; [READ-ONLY] I/O APIC Base Address register. Exposes the absolute physical 
; memory location (MMIO) where the IOAPICs redirection tables reside.


; --- SUBSYSTEM CODENAME: HISTORICAL x86 8254 PROGRAMMABLE INTERVAL TIMER ---
; EXPLANATION: Legacy, hardwired hardware counter ports preserved in modern 
; chipsets. Ideal for fallback clock telemetry and raw time consistency auditing.
; ------------------------------------------------------------------------------
%define LEGACY_PIT_CHANNEL_0            0x0040     
; [READ-ONLY] System Timer Counter Port. Free-running electrical clock counter.
; Queried via direct 'IN' opcode execution to fetch atomic timing byte intervals.

%define LEGACY_PIT_COMMAND_REG          0x0043     
; [READ-ONLY] PIT Mode/Command register window. Used strictly for passive reading 
; to snapshot operational clock states without triggering system synchronization faults.

; ==============================================================================
; 🔌 CATEGORY 5: AMD USB & NETWORK CONTROLLERS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Maps the physical connection points for external data ingress.
; These coordinates allow the SMM code to passive-scan peripheral controllers
; and identify rogue USB interception hardware or network driver level anomalies.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD XHCI USB 3.2 CONTROLLER ---
; EXPLANATION: The primary physical silicon host controller managing external 
; high-speed USB ports. Highly critical for monitoring malicious physical injections.
; ------------------------------------------------------------------------------
%define AMD_CORE_USB_COORDINATE         0x80006000 
; [READ-ONLY] Geometric absolute address targeting Bus 0, Device 12, Function 0.
; Points the radar to the physical AM5 primary extensible Host Controller Interface.

%define AMD_REG_USB_CAP_LENGTH          0x20       
; [READ-ONLY] Capability Length register offset. Fused hardware register disclosing 
; the structural bounds and operational capability parameters of the USB engine.


; --- SUBSYSTEM CODENAME: AMD DUAL-PORT USB ARCHITECTURE ---
; EXPLANATION: Secondary embedded hardware controller routing legacy components, 
; motherboard headers, and internal peripheral system interfaces.
; ------------------------------------------------------------------------------
%define AMD_SEC_USB_COORDINATE          0x80006800 
; [READ-ONLY] Geometric absolute address targeting Bus 0, Device 13, Function 0.
; Points the radar directly to the secondary embedded USB silicon subsystem.


; --- SUBSYSTEM CODENAME: AMD INTEGRATED CORENIC (PHYSICAL NETWORK LINK) ---
; EXPLANATION: The physical motherboard network controller interface handling 
; raw Ethernet lines. Audited to watch for early boot network state compromises.
; ------------------------------------------------------------------------------
%define AMD_FCH_NIC_COORDINATE          0x80007000 
; [READ-ONLY] Geometric absolute address targeting Bus 0, Device 14, Function 0.
; Points the radar directly to the hardwired physical AMD Network Interface Core.

; ==============================================================================
; 📊 CATEGORY 6: AMD POWER MANAGEMENT & DATA FABRIC INTERFACES (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the internal hardware power grid and internal telemetry 
; router. These coordinates allow the SMM code to passive-scan power scaling, 
; system management nodes, and core interconnect states to detect hardware-level 
; timing attacks or illegal dynamic voltage manipulations.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD SMU INTERFACE (SYSTEM MANAGEMENT UNIT) ---
; EXPLANATION: The SMU is an embedded co-processor responsible for controlling 
; the power-up sequence, thermal thresholds, and physical clock boosting inside 
; the CPU die. Audited to monitor hardware stress indicators.
; ------------------------------------------------------------------------------
%define AMD_SMU_RADAR_COORDINATE        0x80000000 ; Shared Host Bridge Base Routing 
%define AMD_REG_SMU_INDEX_ADDR          0xB8       ; [READ-ONLY] Index register pointer to tap internal SMU data lanes
%define AMD_REG_SMU_DATA_WINDOW         0xBC       ; [READ-ONLY] Data window register to extract targeted SMU payload


; --- SUBSYSTEM CODENAME: AMD INTERNAL DATA FABRIC ROUTER (INFINITY FABRIC MAP) ---
; EXPLANATION: The physical hardware bus interconnecting the CPU cores, memory 
; controllers, and I/O hubs. Auditing this configuration layout exposes 
; how data packages are structurally routed across the silicon architecture.
; ------------------------------------------------------------------------------
%define AMD_DATA_FABRIC_COORDINATE      0x80009000 ; Bus 0, Device 18, Function 0 (Primary Data Fabric Node)
%define AMD_REG_DF_CAPABILITIES         0x40       ; [READ-ONLY] Read-only capabilities register detailing routing speeds


; --- SUBSYSTEM CODENAME: AMD FCH POWER MANAGEMENT INTERFACE (PM CONFIG) ---
; EXPLANATION: Embedded hardware block within the Southbridge managing low-level 
; motherboard power transitions, sleep states, and legacy power rail logic.
; ------------------------------------------------------------------------------
%define AMD_FCH_PM_COORDINATE           0x8000F800 ; Aligned with the physical LPC/eSPI Hub base
%define AMD_REG_PM_DECODE_EN            0xBA       ; [READ-ONLY] Read-only validation byte for power configuration routing

; ==============================================================================
; 🗺️ CATEGORY 7: AMD DATA FABRIC CONFIGURATION & MEMORY CONTROLLER NODES (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the advanced routing registers of the AMD Infinity Fabric 
; and the physical Unified Memory Controllers (UMCs). These coordinates enable 
; the SMM code to passive-scan memory channel interleaving, bus clock ratios, 
; and physical DRAM address maps to safeguard memory space integrity.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD DATA FABRIC LINK CONTROL (NODE 0, FUNCTION 1) ---
; EXPLANATION: Manages the internal physical interfaces connecting different die 
; segments (CCX) to the I/O die. Audited to monitor internal interconnect health.
; ------------------------------------------------------------------------------
%define AMD_DF_LINK_CONTROL_COORDINATE  0x80009100 ; Bus 0, Device 18, Function 1
%define AMD_REG_DF_LINK_CAPABILITIES    0x84       ; [READ-ONLY] Read-only capabilities status for link routing


; --- SUBSYSTEM CODENAME: AMD DATA FABRIC CACHE COHERENCY (NODE 0, FUNCTION 2) ---
; EXPLANATION: Controls the strict hardware cache coherency protocols across 
; the Infinity Fabric, ensuring all CPU cores see the exact same state of memory.
; ------------------------------------------------------------------------------
%define AMD_DF_COHERENCY_COORDINATE     0x80009200 ; Bus 0, Device 18, Function 2


; --- SUBSYSTEM CODENAME: AMD UNIFIED MEMORY CONTROLLER CONFIG (UMC CHANNELS) ---
; EXPLANATION: Node 0, Function 4 directly accesses the physical DDR5 Memory 
; Controller. Sniffing this target exposes physical memory bus speeds, refresh 
; intervals, and active hardware-level memory scrubbing configurations.
; ------------------------------------------------------------------------------
%define AMD_UMC_CONFIG_COORDINATE       0x80009400 ; Bus 0, Device 18, Function 4
%define AMD_REG_UMC_DRAM_TIMING         0x48       ; [READ-ONLY] Read-only timing matrix status of the physical DRAM channels

; ==============================================================================
; 🔐 CATEGORY 8: AMD SEV & PLATFORM HARDWARE CAPABILITIES (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical capabilities and encryption status engines 
; exposed by the AMD PCIe routing layer. These coordinates enable the SMM code 
; to passive-scan hardware encryption flags (SME/SEV) and physical socket execution 
; constraints to verify that the absolute baseline protection architecture is active.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD CRYPTO EXTENSIONS AUDIT (NODE 0, FUNCTION 5) ---
; EXPLANATION: Targets the internal routing function of Device 18 that exposes 
; the security feature capability state of the Zen core layout. Sniffing this 
; target reports if SME/SEV memory page encryption engines are hardware-fused.
; ------------------------------------------------------------------------------
%define AMD_DF_SECURITY_COORDINATE      0x80009500 ; Bus 0, Device 18, Function 5
%define AMD_REG_SEV_STATUS_CAP          0x4C       ; [READ-ONLY] Read-only capabilities status for SEV memory bit allocation


; --- SUBSYSTEM CODENAME: AMD PHYSICAL SOCKET LAYER METRICS (NODE 0, FUNCTION 6) ---
; EXPLANATION: Exposes hardware platform configuration indicators, including 
; socket pin-mapping layouts and physical link topology rules applied by the manufacturer.
; ------------------------------------------------------------------------------
%define AMD_DF_PLATFORM_COORDINATE      0x80009600 ; Bus 0, Device 18, Function 6


; --- SUBSYSTEM CODENAME: AMD MULTI-NODE FABRIC LINK REGISTER (NODE 0, FUNCTION 7) ---
; EXPLANATION: Exposes low-level physical cross-die configuration states used on 
; multi-chip module (MCM) processor designs to balance data flow between separate dies.
; ------------------------------------------------------------------------------
%define AMD_DF_MULTINODE_COORDINATE     0x80009700 ; Bus 0, Device 18, Function 7
%define AMD_REG_FABRIC_TOPOLOGY         0x50       ; [READ-ONLY] Fused architecture register displaying die topology routing

; ==============================================================================
; 🚌 CATEGORY 9: AMD CORE LINK FRAMEWORK & IO HUB MATRIX (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the internal hardware link bridges and core I/O routing hubs 
; exposed within the physical silicon layers. These constants enable the SMM code 
; to passive-scan internal core-to-I/O die transactions and verify that the high-speed 
; system bus interfaces operate within secure architectural constraints.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD INTERNAL ROOT COMPLEX BRIDGE (LINK CONTROLLER) ---
; EXPLANATION: The structural silicon core linkage routing communications between 
; the primary CPU physical processing die and the local embedded motherboard components.
; ------------------------------------------------------------------------------
%define AMD_ROOT_COMPLEX_COORDINATE     0x80000000 ; Primary architectural Bus 0 intersection
%define AMD_REG_ROOT_CAPABILITIES       0x34       ; [READ-ONLY] Capabilities pointer index tracking hardware features


; --- SUBSYSTEM CODENAME: AMD DYNAMIC PCIE DOWNSTREAM PORT ARCHITECTURE ---
; EXPLANATION: Maps the high-speed downstream interface lanes utilized by auxiliary 
; controllers and expander chips baked directly onto AM5 motherboard layers.
; ------------------------------------------------------------------------------
%define AMD_PCIE_DOWNSTREAM_PORT        0x80000E00 ; Bus 0, Device 1, Function 5
%define AMD_REG_PCI_STATUS              0x06       ; [READ-ONLY] Status register mask monitoring physical interface health


; --- SUBSYSTEM CODENAME: AMD SECONDARY INTERNAL ROUTING SYSTEM (IO BRIDGE) ---
; EXPLANATION: Secondary structural system interface inside the FCH managing internal 
; cross-bus message passing and legacy resource assignment rules.
; ------------------------------------------------------------------------------
%define AMD_INTERNAL_IO_BRIDGE          0x8000F800 ; Aligned within the core LPC/eSPI Hub routing layer
%define AMD_REG_IO_DECODE_EN            0x48       ; [READ-ONLY] Fused validation byte displaying active I/O window assignments

; ==============================================================================
; 🎧 CATEGORY 10: AMD INTERNAL AUDIO & HIGH-DEFINITION MULTIMEDIA HUBS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the built-in High-Definition Audio (HDA) controllers and 
; multimedia co-processors baked into the AMD chip layout. These constants allow 
; the SMM layer to passive-scan subsystem states, verify device capabilities, 
; and monitor hardware resource allocation to eliminate audio-based side-channel risks.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD AZALIA HIGH-DEFINITION AUDIO CORE ---
; EXPLANATION: The physical motherboard audio host controller managing hardware 
; codecs, microphone lines, and audio output buses embedded in the AM5 framework.
; ------------------------------------------------------------------------------
%define AMD_HDA_AUDIO_COORDINATE        0x8000F814 ; Bus 0, Device 31, Function 1 (FCH Audio Node)
%define AMD_REG_HDA_SUB_VENDOR_ID       0x2C       ; [READ-ONLY] Offset for Subsystem Vendor Identity check


; --- SUBSYSTEM CODENAME: AMD DISPLAY AUDIO CONTROLLER (HDMI/DP SOUND HUB) ---
; EXPLANATION: Embedded digital multimedia audio engine integrated into the CPUs 
; internal graphics pipeline to route audio packets across display lanes.
; ------------------------------------------------------------------------------
%define AMD_DISPLAY_AUDIO_COORDINATE    0x80000801 ; Bus 0, Device 1, Function 1 (Display Audio)


; --- SUBSYSTEM CODENAME: AMD ACP AUDIO CO-PROCESSOR (DSP HARDWARE NO_DE) ---
; EXPLANATION: An auxiliary physical Audio Co-Processor running microarchitectural 
; digital signal processing (DSP). Audited to check dedicated execution status.
; ------------------------------------------------------------------------------
%define AMD_ACP_COPROCESSOR_COORDINATE  0x80000B00 ; Bus 0, Device 1, Function 3
%define AMD_REG_ACP_REVISION            0x08       ; [READ-ONLY] Fused revision byte tracking ACP silicon layer version

; ==============================================================================
; 📺 CATEGORY 11: AMD INTEGRATED GRAPHICS & DISPLAY CONTROLLER COMPLEXES (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the embedded internal Graphics Processing Unit (iGPU) and 
; display configuration engines built directly into the AM5 architecture. These 
; constants enable the SMM layer to passive-scan graphics memory allocations, 
; verify video pipeline states, and monitor hardware frame-buffer routing to 
; defend against unauthorized GPU-assisted memory extraction.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD INTEGRATED GRAPHICS CONTROLLER CORE ---
; EXPLANATION: The main hardware anchor point for the embedded Radeon GPU core.
; Audited to verify structural layout characteristics and hardware frame buffers.
; ------------------------------------------------------------------------------
%define AMD_IGPU_CORE_COORDINATE        0x80004000 ; Bus 0, Device 8, Function 0 (Primary iGPU)
%define AMD_REG_IGPU_SUB_DEVICE_ID      0x2E       ; [READ-ONLY] Offset for physical Subsystem Device ID check


; --- SUBSYSTEM CODENAME: AMD VIDEO ACCELERATION BLOCK (VCN MATRIX) ---
; EXPLANATION: Dedicated silicon hardware encoder/decoder (Video Core Next) within 
; the integrated graphics pipeline. Monitored to check hardware feature exposure.
; ------------------------------------------------------------------------------
%define AMD_VCN_ACCELERATOR_COORDINATE  0x80004200 ; Bus 0, Device 8, Function 2


; --- SUBSYSTEM CODENAME: AMD PHYSICAL DISPLAY LINK CONTROLLER ---
; EXPLANATION: Hardware pipeline handling configuration routing to actual physical 
; display output pins (HDMI/DisplayPort lanes) embedded on the motherboard.
; ------------------------------------------------------------------------------
%define AMD_DISPLAY_LINK_COORDINATE     0x80004300 ; Bus 0, Device 8, Function 3
%define AMD_REG_DISPLAY_CAPABILITIES    0x40       ; [READ-ONLY] Architectural configuration capabilities pointer index

; ==============================================================================
; 🗺️ CATEGORY 12: AMD SYSTEM VIRTUALIZATION, IOMMU WINDOWS & ACPI GATEWAYS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the high-level virtualization mapping windows, IOMMU base
; address tracking registers, and foundational ACPI event reporting frameworks.
; These constants enable the SMM code to passive-scan memory-mapped I/O (MMIO) 
; windows and ensure that external devices have not compromised the system boundaries.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD INTEGRATED CORELINK HOST VIRTUALIZATION GAP ---
; EXPLANATION: Targets the secondary capability registers of Bus 0, Device 0, 
; Function 0 that report the physical routing layout for virtualization apertures.
; ------------------------------------------------------------------------------
%define AMD_VIRT_BRIDGE_COORDINATE      0x80000000 ; Primary architectural Host Bridge Base
%define AMD_REG_VIRT_APERTURE_CAP       0x80       ; [READ-ONLY] Read-only verification byte for memory apertures


; --- SUBSYSTEM CODENAME: AMD-Vi IOMMU BASE CONFIGURATION MAP (MMIO WINDOW) ---
; EXPLANATION: Node 0, Device 0, Function 2 manages the advanced capabilities 
; of the IOMMU firewall. Sniffing this target exposes the exact 64-bit physical 
; address where the hardware memory mapping registers are located in the system.
; ------------------------------------------------------------------------------
%define AMD_IOMMU_BASE_COORDINATE       0x80000400 ; Bus 0, Device 0, Function 2 (IOMMU Controller)
%define AMD_REG_IOMMU_BASE_LOW          0x14       ; [READ-ONLY] Read-only tracking register for lower 32-bits of MMIO Base
%define AMD_REG_IOMMU_BASE_HIGH         0x18       ; [READ-ONLY] Read-only tracking register for upper 32-bits of MMIO Base


; --- SUBSYSTEM CODENAME: AMD ACPI INTERFACE & POWER STATE TRAFFIC ---
; EXPLANATION: Configures physical resource offsets within the FCH Southbridge 
; used to manage hardware power button events, sleep timers, and ACPI tables.
; ------------------------------------------------------------------------------
%define AMD_FCH_ACPI_COORDINATE         0x8000F800 ; Shared FCH Controller Hub alignment
%define AMD_REG_ACPI_PM_BASE            0x60       ; [READ-ONLY] Read-only byte verifying hardware layout configuration for ACPI

; ==============================================================================
; 🌡️ CATEGORY 13: AMD PLATFORM THERMAL MONITORING & SENSOR FRAMEWORKS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware thermal reporting nodes and low-level
; sensor configuration windows built into the AMD architecture. These constants 
; enable the SMM layer to passive-scan die temperatures and hardware fan metrics
; to verify systemic health and mitigate physical thermal side-channel analysis.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD CORE TEMPERATURE REPORTING COMPLEX ---
; EXPLANATION: Dedicated hardware management interface that reports the active
; digital thermal sensor (DTS) readouts directly from the silicon die.
; ------------------------------------------------------------------------------
%define AMD_THERMAL_NODE_COORDINATE     0x80009300 ; Bus 0, Device 18, Function 3 (Data Fabric Miscellaneous Control)
%define AMD_REG_THERMAL_STATUS_REPORT   0xA4       ; [READ-ONLY] Offset to pull raw digital temperature telemetry from the iron


; --- SUBSYSTEM CODENAME: AMD FCH SYSTEM MANAGEMENT CONTROLLER (HARDWARE MONITOR) ---
; EXPLANATION: Hardware interface within the Southbridge that bridges physical 
; thermal sensors scattered across the motherboard traces to the CPU interface.
; ------------------------------------------------------------------------------
%define AMD_FCH_HWM_COORDINATE          0x8000F800 ; Shared FCH Controller Hub alignment
%define AMD_REG_HWM_DECODE_INDEX        0x4C       ; [READ-ONLY] Read-only verification byte tracking hardware monitor routing


; --- SUBSYSTEM CODENAME: AMD UNIVERSAL SMBus INTERNAL STATUS SLOTS ---
; EXPLANATION: Offset pointers used when communication lines are opened through 
; port 0x0F810 to sniff physical registers inside memory controller paths.
; ------------------------------------------------------------------------------
%define AMD_SMBUS_REG_HOST_STATUS       0x00       ; [READ-ONLY] Read-only interface tracking the SMBus continuous state machine

; ==============================================================================
; 🔒 CATEGORY 14: AMD EMBEDDED SYSTEM MANAGEMENT & HARDWARE WATCHDOGS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware watchdog timers and configuration 
; windows for motherboard embedded controllers (SuperI/O interfaces). 
; These constants enable the SMM layer to passive-scan platform reset triggers 
; and legacy hardware configuration gates to ensure systemic isolation.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FCH HARDWARE WATCHDOG CONTROLLER ---
; EXPLANATION: Fused hardware countdown timer built into the AMD Southbridge. 
; If not reset by trusted code, it triggers an immediate hard reset of the board.
; ------------------------------------------------------------------------------
%define AMD_FCH_WDT_COORDINATE          0x8000F800 ; Aligned with the physical LPC/eSPI Hub base
%define AMD_REG_WDT_CONTROL_OFFSET      0x6C       ; [READ-ONLY] Read-only verification byte tracking watchdog enablement


; --- SUBSYSTEM CODENAME: AMD LEGACY SUPER I/O CONFIGURATION INDEX WINDOW ---
; EXPLANATION: Architectural I/O port used to select internal registers of the 
; motherboards secondary hardware controller (e.g., Nuvoton or ITE chip).
; ------------------------------------------------------------------------------
%define LEGACY_SUPERIO_INDEX_PORT       0x002E     ; [READ-ONLY] SuperI/O hardware configuration index (via IN)


; --- SUBSYSTEM CODENAME: AMD LEGACY SUPER I/O CONFIGURATION DATA WINDOW ---
; EXPLANATION: Architectural I/O port used to read out targeted data values 
; from the motherboard peripheral logic matrix selected by the Index Port.
; ------------------------------------------------------------------------------
%define LEGACY_SUPERIO_DATA_PORT        0x002F     ; [READ-ONLY] SuperI/O hardware configuration data (via IN)

; ==============================================================================
; ⚡ CATEGORY 15: AMD POWER RAIL INFRASTRUCTURE & VRM TELEMETRY (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical power infrastructure registers and legacy
; hardware reset status gateways embedded on the motherboard. These constants
; enable the SMM layer to passive-scan power management controller (PMC) loops
; and track raw voltage scaling events to mitigate side-channel fault injection.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD PMC HARDWARE STATUS GATEWAY (POWER MANAGEMENT) ---
; EXPLANATION: The physical Power Management Controller (PMC) within the AMD FCH.
; Audited to read low-level motherboard energy state handshakes and power rails.
; ------------------------------------------------------------------------------
%define AMD_FCH_PMC_COORDINATE          0x8000F800 ; Aligned within the core LPC/eSPI Hub routing layer
%define AMD_REG_PMC_RST_STATUS          0x70       ; [READ-ONLY] Read-only register exposing the physical cause of the last hardware reset


; --- SUBSYSTEM CODENAME: HISTORICAL x86 SYSTEM CONTROL & HARD RESET PORT ---
; EXPLANATION: Standard x86 hardware register used to trigger motherboard-level
; resets. Monitored passively via IN to verify hardware state consistency.
; ------------------------------------------------------------------------------
%define LEGACY_SYSTEM_RESET_PORT        0x0CF9     ; [READ-ONLY] Architectural reset control gateway (via IN)


; --- SUBSYSTEM CODENAME: AMD REAL-TIME PHYSICAL CORE VOLTAGE TELEMETRY ---
; EXPLANATION: Internal indexing offset used when tapping the hardware monitoring
; framework to extract raw digital readouts from the motherboards VRM.
; ------------------------------------------------------------------------------
%define AMD_HWM_REG_VCORE_SENSE         0x20       ; [READ-ONLY] Fused telemetry offset tracking active CPU voltage stabilization

; ==============================================================================
; 💾 CATEGORY 16: AMD EMBEDDED SPI/eSPI CONTROLLER CONFIGURATIONS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the hardware SPI/eSPI host controller embedded inside the 
; AMD Southbridge (FCH). These constants enable the SMM layer to passive-scan 
; firmware peripheral access routing, memory-mapped SPI windows (SPI BAR), and 
; hardware interface configurations to ensure the BIOS Flash remains fully isolated.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FCH SPI CONTROLLER HARDWARE RADAR ---
; EXPLANATION: Dedicated hardware engine within the FCH handling direct physical 
; read/write transactions to the physical SPI Flash memory chip.
; ------------------------------------------------------------------------------
%define AMD_FCH_SPI_COORDINATE          0x8000F800 ; Aligned with the physical LPC/eSPI Hub base routing
%define AMD_REG_SPI_BASE_ADDR_LOW       0xA0       ; [READ-ONLY] Read-only verification register for lower 32-bits of SPI BAR
%define AMD_REG_SPI_BASE_ADDR_HIGH      0xA4       ; [READ-ONLY] Read-only verification register for upper 32-bits of SPI BAR


; --- SUBSYSTEM CODENAME: AMD eSPI PERIPHERAL CAPABILITIES INTERFACE ---
; EXPLANATION: Modern Enhanced Serial Peripheral Interface (eSPI) configuration register. 
; Exposes hardware status regarding slave device capabilities and firmware channel rules.
; ------------------------------------------------------------------------------
%define AMD_REG_ESPI_CAP_REG            0xA8       ; [READ-ONLY] Fused architecture register displaying active eSPI bus metrics

; ==============================================================================
; ⚙️ CATEGORY 17: AMD MISCELLANEOUS PLATFORM CONTROL & HARDWARE STRAPS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware configuration straps and miscellaneous
; platform routing control registers embedded inside the AMD Southbridge (FCH).
; These constants enable the SMM layer to passive-scan power-on strap states, 
; verify motherboard trace definitions, and monitor core silicon execution shapes.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FCH MISCELLANEOUS PLATFORM RADAR ---
; EXPLANATION: Internal hardware logic gate cluster responsible for exposing 
; raw power-on-strap (POS) configurations sampled at the exact second of boot.
; ------------------------------------------------------------------------------
%define AMD_FCH_MISC_COORDINATE         0x8000F800 ; Aligned with the physical LPC/eSPI Hub base routing
%define AMD_REG_MISC_STRAPS_LOW         0xF0       ; [READ-ONLY] Read-only verification register for lower 32-bits of Hardware Straps
%define AMD_REG_MISC_STRAPS_HIGH        0xF4       ; [READ-ONLY] Read-only verification register for upper 32-bits of Hardware Straps


; --- SUBSYSTEM CODENAME: AMD HW PIN ASSIGNMENT & CONFIGURATION AUDIT ---
; EXPLANATION: Architectural configuration register logging the layout state of 
; motherboard general-purpose input/output (GPIO) routing shapes.
; ------------------------------------------------------------------------------
%define AMD_REG_MISC_PIN_CAPABILITIES   0xF8       ; [READ-ONLY] Fused register displaying active physical die strapping configurations

; ==============================================================================
; 🚌 CATEGORY 18: AMD MULTI-DIE LINK FABRIC & CORES INTERCONNECTS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical chiplet interconnection fabric and multi-die 
; linkage arrays exposed within the internal hardware matrix. These constants 
; enable the SMM layer to passive-scan internal core-to-core and die-to-die (CCD-to-IOD) 
; transaction links to verify that internal routing operations remain secure.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD CORE COMPLEX INTERCONNECT ROUTING (NODE 0, FUNCTION 0) ---
; EXPLANATION: Targets the foundational hardware capability mapping registers 
; of Bus 0, Device 18, Function 0 that report the physical scale of the fabric lanes.
; ------------------------------------------------------------------------------
%define AMD_DF_NODE_CONFIG_COORDINATE   0x80009000 ; Bus 0, Device 18, Function 0 (Data Fabric Base Node)
%define AMD_REG_DF_NODE_ID_TRACKER      0x04       ; [READ-ONLY] Offset to pull raw physical multi-socket and die index bits


; --- SUBSYSTEM CODENAME: AMD MULTI-CHIP ROUTING QUEUE TRACKING (LINK 1) ---
; EXPLANATION: Secondary hardware interface configuration mapping the transaction 
; buffer statuses and internal queues processing traffic across separate silicon chiplets.
; ------------------------------------------------------------------------------
%define AMD_DF_LINK_QUEUE_COORDINATE    0x80009300 ; Bus 0, Device 18, Function 3 (DF Misc Control alignment)
%define AMD_REG_DF_QUEUE_STATUS         0x9C       ; [READ-ONLY] Fused architecture register displaying active buffer allocations


; --- SUBSYSTEM CODENAME: AMD PHYSICAL FABRIC PERFORMANCE MONITOR ENABLER ---
; EXPLANATION: Exposes the read-only hardware register layout defining whether 
; passive hardware-level performance counters for the Infinity Fabric are enabled.
; ------------------------------------------------------------------------------
%define AMD_REG_DF_PERF_MON_STATUS      0xFC       ; [READ-ONLY] Read-only capabilities indicator for core traffic observation

; ==============================================================================
; ⏱️ CATEGORY 19: AMD CLOCK DISTRIBUTION & TELEMETRY ANCHORS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware clock routing meshes and low-power
; configuration controllers embedded within the AMD Southbridge (FCH).
; These constants enable the SMM layer to passive-scan dynamic clock gating, 
; verify platform timing baselines, and monitor sub-frequency execution nodes.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FCH CLOCK INTERFACE & GATING MATRIX ---
; EXPLANATION: Internal hardware logic gate cluster responsible for managing
; and distributing physical clock signals across motherboard lanes.
; ------------------------------------------------------------------------------
%define AMD_FCH_CLK_COORDINATE          0x8000F800 ; Aligned with the physical LPC/eSPI Hub base routing
%define AMD_REG_CLK_GATE_STATUS         0xD0       ; [READ-ONLY] Read-only verification register monitoring dynamic clock state masks


; --- SUBSYSTEM CODENAME: AMD LOW-POWER ARCHITECTURE CONFIGURATION AUDIT ---
; EXPLANATION: Architectural configuration register logging the hardware status
; of energy saving infrastructure and low-power engine states (Deep Sleep nodes).
; ------------------------------------------------------------------------------
%define AMD_REG_LOW_POWER_CONFIG        0xD4       ; [READ-ONLY] Fused register displaying active physical state telemetry


; --- SUBSYSTEM CODENAME: AMD PLATFORM TIMING OFFSET MASK ---
; EXPLANATION: Secondary hardware interface register tracking physical clock sync
; configurations to ensure sub-system timers remain tethered to the master crystal.
; ------------------------------------------------------------------------------
%define AMD_REG_PLATFORM_TIMER_SYNC     0xD8       ; [READ-ONLY] Read-only capabilities indicator for platform clock telemetry

; ==============================================================================
; ⚙️ CATEGORY 20: AMD HARDWARE SECURITY TESTING & INITIALIZATION LOCKS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware status controllers logging the 
; final platform initialization vectors and factory silicon fusing indicators. 
; These constants enable the SMM layer to passive-scan embedded test mechanisms 
; and ensure that the manufacturers silicon debug gateways remain permanently frozen.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FCH INITIALIZATION CONFIGURATION RADAR ---
; EXPLANATION: Embedded hardware gate cluster within the AMD Southbridge responsible 
; for logging platform boot capabilities and structural boot-strap routing layers.
; ------------------------------------------------------------------------------
%define AMD_FCH_INIT_COORDINATE         0x8000F800 ; Aligned with the physical LPC/eSPI Hub base routing
%define AMD_REG_INIT_BOOT_LOCK_STATUS   0xE0       ; [READ-ONLY] Read-only verification register monitoring platform initialization locks


; --- SUBSYSTEM CODENAME: AMD FACTORY SILICON FUSING CONFIGURATION AUDIT ---
; EXPLANATION: Architectural configuration register logging the hardware status 
; of factory-burned security fuses, confirming whether the chip is in production state.
; ------------------------------------------------------------------------------
%define AMD_REG_SILICON_PRODUCTION_FLAG 0xE4       ; [READ-ONLY] Fused register displaying active manufacturing security status


; --- SUBSYSTEM CODENAME: AMD PLATFORM DEBUG GATEWAY CONTROLLER ---
; EXPLANATION: Secondary hardware interface register tracking physical test-mode 
; configurations to ensure hardware-level test loops are completely isolated.
; ------------------------------------------------------------------------------
%define AMD_REG_TEST_INTERFACE_CONTROL  0xE8       ; [READ-ONLY] Read-only capabilities indicator for system debugging metrics

; ==============================================================================
; 🚨 CATEGORY 21: AMD HARDWARE ERROR MONITORING & RAS ARCHITECTURE (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware reliability and error logging controllers 
; (RAS architecture) embedded across the AMD chipset fabric. These constants enable 
; the SMM layer to passive-scan internal interconnect failures and ECC alerts to 
; detect hardware-level disruption attempts before system panic occurs.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD DATA FABRIC ERROR LOGGING CONTROL ---
; EXPLANATION: Dedicated hardware monitoring register inside Device 18, Function 0 
; responsible for counting and logging hardware-level errors across the Infinity Fabric.
; ------------------------------------------------------------------------------
%define AMD_DF_ERROR_COORDINATE         0x80009000 ; Shared Data Fabric Base Node 
%define AMD_REG_DF_ERR_COUNT_STATUS     0x48       ; [READ-ONLY] Read-only verification register monitoring internal fabric error counts


; --- SUBSYSTEM CODENAME: AMD RAS GLOBAL CONFIGURATION AUDIT ---
; EXPLANATION: Architectural configuration register logging the hardware status 
; of core interconnect reliability features and advanced platform recovery maps.
; ------------------------------------------------------------------------------
%define AMD_REG_GLOBAL_RAS_CAPS         0x4C       ; [READ-ONLY] Fused register displaying active hardware reliability and serviceability frameworks


; --- SUBSYSTEM CODENAME: AMD MCA EXTENDED REPORTING REGISTERS GATEWAY ---
; EXPLANATION: Read-only index offset used to passively check if the chipsets 
; extended Machine Check Architecture (MCA) registers are active and exposed to the host.
; ------------------------------------------------------------------------------
%define AMD_REG_MCA_EXT_STATUS_CONTROL  0x50       ; [READ-ONLY] Read-only capabilities indicator for global hardware fault monitoring

; ==============================================================================
; 🏎️ CATEGORY 22: AMD CORE PERFORMANCE BOOST & CPPC VECTORS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware performance boost matrices and CPPC 
; (Collaborative Processor Performance Control) capability logs inside the AMD fabric.
; These constants enable the SMM layer to passive-scan physical boost ratios and 
; hardware energy caps to verify that the core performance grid remains static.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD CPPC CAPABILITIES CONTROLLER ---
; EXPLANATION: Dedicated hardware capability interface inside Device 18, Function 0 
; that logs maximum, guaranteed, and lowest hardware performance steps.
; ------------------------------------------------------------------------------
%define AMD_DF_CPPC_COORDINATE          0x80009000 ; Shared Data Fabric Base Node
%define AMD_REG_DF_CPPC_HIGHEST_PERF    0x64       ; [READ-ONLY] Read-only verification register monitoring microarchitectural boost caps


; --- SUBSYSTEM CODENAME: AMD ENERGY CONFIGURATION ARCHITECTURE AUDIT ---
; EXPLANATION: Architectural configuration register logging the hardware status 
; of physical energy throttling and thermal performance scaling bounds.
; ------------------------------------------------------------------------------
%define AMD_REG_GLOBAL_BOOST_CONTROL    0x68       ; [READ-ONLY] Fused register displaying active core frequency boost limits


; --- SUBSYSTEM CODENAME: AMD FABRIC PERFORMANCE SCALE INDICATOR ---
; EXPLANATION: Read-only index offset used to passively check if the chipsets 
; embedded frequency scaling counters are active and reporting correct hardware steps.
; ------------------------------------------------------------------------------
%define AMD_REG_DF_FREQ_SCALE_STATUS    0x6C       ; [READ-ONLY] Read-only capabilities indicator for core performance monitoring

; ==============================================================================
; 🧠 CATEGORY 23: AMD CORE COMPLEX CACHE TOPOLOGY & L3 ISOLATION (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware cache topology configurations and 
; Core Complex (CCX) L3 cache isolation status metrics within the AMD fabric.
; These constants enable the SMM layer to passive-scan internal cache sizing, 
; cross-CCX bus properties, and layout metrics to audit cache side-channel risks.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD CCX CACHE CONFIGURATION TRACKER (NODE 0, FUNCTION 3) ---
; EXPLANATION: Dedicated architectural register block inside Device 18, Function 3 
; that logs physical L3 cache slice associations, core masks, and sharing topology rules.
; ------------------------------------------------------------------------------
%define AMD_DF_CACHE_TOPOLOGY_COORDINATE 0x80009300 ; Shared Data Fabric Misc Control Node
%define AMD_REG_DF_L3_CACHE_CAPS        0xB4       ; [READ-ONLY] Read-only verification register monitoring internal L3 slice configurations


; --- SUBSYSTEM CODENAME: AMD CROSS-CCX BUS INTERCONNECT METRICS ---
; EXPLANATION: Architectural configuration register logging the hardware status 
; of physical transaction queue depth and throughput constraints between separate core complexes.
; ------------------------------------------------------------------------------
%define AMD_REG_CROSS_CCX_BUS_CONTROL   0xC8       ; [READ-ONLY] Fused register displaying active interconnect bandwidth thresholds


; --- SUBSYSTEM CODENAME: AMD CACHE WAY ALLOCATION CAPABILITIES ---
; EXPLANATION: Read-only index offset used to passively check if the chipsets 
; internal cache way allocation controls and partitioning maps are locked or exposed.
; ------------------------------------------------------------------------------
%define AMD_REG_CACHE_ALLOC_STATUS      0xCC       ; [READ-ONLY] Read-only capabilities indicator for core cache partitioning telemetry

; ==============================================================================
; 🛰️ CATEGORY 24: AMD HARDWARE TELEMETRY HUB & SMN ACCESS PORTS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware System Management Network (SMN) 
; communication bridges and the embedded FCH Mailbox telemetry registers. 
; These constants enable the SMM layer to passive-scan internal network bridges 
; and monitor cross-subsystem command windows to detect stealth silicon exploitation.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD SMN CONFIGURATION INDEX HUB ---
; EXPLANATION: Dedicated hardware mapping register inside Device 18, Function 0 
; acting as the index gateway pointer to tap the private System Management Network.
; ------------------------------------------------------------------------------
%define AMD_DF_SMN_INDEX_COORDINATE     0x80009000 ; Shared Data Fabric Base Node 
%define AMD_REG_DF_SMN_INDEX_ADDR       0x60       ; [READ-ONLY] Read-only register pointing to internal SMN physical tracking lines


; --- SUBSYSTEM CODENAME: AMD SMN CONFIGURATION DATA WINDOW ---
; EXPLANATION: Architectural configuration register acting as the read-only data window 
; to extract raw telemetry from the SMN space previously targeted by the Index register.
; ------------------------------------------------------------------------------
%define AMD_REG_DF_SMN_DATA_WINDOW      0x64       ; [READ-ONLY] Fused register displaying extracted internal SMN data payloads


; --- SUBSYSTEM CODENAME: AMD FCH MAILBOX STATUS CONTROLLER ---
; EXPLANATION: Read-only hardware command box used by the FCH Southbridge to send 
; telemetry status updates directly to the CPUs internal system management units.
; ------------------------------------------------------------------------------
%define AMD_FCH_MAILBOX_COORDINATE      0x8000F800 ; Aligned within the core LPC/eSPI Hub routing layer
%define AMD_REG_MAILBOX_STATUS          0xE4       ; [READ-ONLY] Read-only capabilities indicator for mailbox command validation

; ==============================================================================
; 🧠 CATEGORY 25: AMD MEMORY SCRUBBING & DRAM ECC CONFIGURATIONS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware memory scrubbers (Scavenger engines)
; and integrated DRAM ECC monitoring structures inside the AMD Memory Controller.
; These constants enable the SMM layer to passive-scan hardware error correction
; rates, memory boundary scrubbing paces, and core DRAM reliability states.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD HARDWARE MEMORY SCRUBBER CONTROL (UMC ENGINES) ---
; EXPLANATION: Dedicated architectural register block inside Device 18, Function 4
; responsible for controlling the atomic hardware background scan over physical DDR5 RAM.
; ------------------------------------------------------------------------------
%define AMD_DF_MEM_SCRUBBER_COORDINATE  0x80009400 ; Unified Memory Controller Config Base
%define AMD_REG_DF_SCRUB_RATE_STATUS    0x5C       ; [READ-ONLY] Read-only verification register monitoring memory background scrubbing speed


; --- SUBSYSTEM CODENAME: AMD ECC ERROR LOGGING & INTRUSION DETECTION ---
; EXPLANATION: Architectural configuration register logging the real-time status
; of DRAM single-bit error corrections (CE) and uncorrectable hardware faults (UE).
; ------------------------------------------------------------------------------
%define AMD_REG_ECC_ERROR_INTRUSION     0x60       ; [READ-ONLY] Fused register displaying active hardware hardware error intercept counts


; --- SUBSYSTEM CODENAME: AMD ADVANCED POISON DETECTION MASTER ---
; EXPLANATION: Read-only index offset used to passively check if the memory controller's
; hardware-level "Data Poisoning" mechanisms are active to isolate corrupted cache lines.
; ------------------------------------------------------------------------------
%define AMD_REG_POISON_ISOLATION_STATUS 0x64       ; [READ-ONLY] Read-only capabilities indicator for global memory defense telemetry

; ==============================================================================
; 🏎️ CATEGORY 26: AMD CORE PERFORMANCE BOOST CACHE LIMITS & PBO MONITORS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware Precision Boost Overdrive (PBO) limits
; and embedded core voltage interconnect safety barriers inside the AMD SMU fabric.
; These constants enable the SMM layer to passive-scan power throttling bounds,
; voltage scaling fences, and core boost overrides to ensure complete hardware stability.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD PBO TELEMETRY MONITOR (NODE 0, FUNCTION 0) ---
; EXPLANATION: Architectural configuration register inside Device 18, Function 0 
; logging the real-time continuous power management status and PBO limit thresholds.
; ------------------------------------------------------------------------------
%define AMD_DF_PBO_LIMIT_COORDINATE     0x80009000 ; Shared Data Fabric Base Node
%define AMD_REG_DF_PBO_MAX_THROTTLE     0x70       ; [READ-ONLY] Read-only verification register monitoring microarchitectural boost limits


; --- SUBSYSTEM CODENAME: AMD SILICON VOLTAGE ISOLATION BARRIER ---
; EXPLANATION: Fused register logging the absolute maximum voltage bounds and 
; hardware-level protection fences configured at boot to prevent silicon degradation.
; ------------------------------------------------------------------------------
%define AMD_REG_GLOBAL_VOLTAGE_FENCE    0x74       ; [READ-ONLY] Fused register displaying active core electrical voltage limits


; --- SUBSYSTEM CODENAME: AMD DYNAMIC ENERGY SCALING COUNTER ---
; EXPLANATION: Read-only index offset used to passively check if the memory and core 
; interconnect power rails are experiencing dynamic power scaling anomalies.
; ------------------------------------------------------------------------------
%define AMD_REG_DF_ENERGY_SCALE_STATUS  0x78       ; [READ-ONLY] Read-only capabilities indicator for core energy grid monitoring

; ==============================================================================
; ⚡ CATEGORY 27: AMD MEMORY POWER MANAGEMENT & DYNAMIC SCALING (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware memory power management controllers 
; and memory channel dynamic scaling thresholds inside the AMD Memory Controller.
; These constants enable the SMM layer to passive-scan dynamic power-down states
; and DDR5 interface clock rails to ensure stable and uncompromised DRAM signaling.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD MEMORY POWER SAVING ENGINE (NODE 0, FUNCTION 4) ---
; EXPLANATION: Architectural configuration register inside Device 18, Function 4
; that logs physical DRAM low-power state entry masks and dynamic refresh scaling status.
; ------------------------------------------------------------------------------
%define AMD_DF_MEM_POWER_COORDINATE     0x80009400 ; Unified Memory Controller Base Node
%define AMD_REG_DF_MEM_PWR_CONFIG       0x68       ; [READ-ONLY] Read-only verification register monitoring memory interface power states


; --- SUBSYSTEM CODENAME: AMD IO DIE ENERGY RAIL TELEMETRY ---
; EXPLANATION: Fused register logging active power management handshakes and dynamic 
; voltage rails specifically handling the physical I/O Die (IOD) infrastructure.
; ------------------------------------------------------------------------------
%define AMD_REG_IOD_POWER_STATUS        0x6C       ; [READ-ONLY] Fused register displaying active I/O Die power rail telemetry


; --- SUBSYSTEM CODENAME: AMD MEMORY CONTROLLER FREQUENCY GATE MASK ---
; EXPLANATION: Read-only index offset used to passively check if the memory controller's 
; internal clock gating and dynamic frequency scaling features are functionally locked.
; ------------------------------------------------------------------------------
%define AMD_REG_MC_CLK_GATING_STATUS    0x70       ; [READ-ONLY] Read-only capabilities indicator for dynamic memory frequency scaling


; ==============================================================================
; 🚨 CATEGORY 28: AMD DATA FABRIC RAS ERROR INJECTION CONTROL & MCA OVERRIDES (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware RAS error injection controls and 
; Machine Check Architecture (MCA) reporting override parameters within the AMD fabric.
; These constants enable the SMM layer to passive-scan internal hardware test loops,
; error masking configurations, and silicon debug overrides to prevent hardware exploitation.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD DATA FABRIC ERROR INJECTION CONTROL (NODE 0, FUNCTION 0) ---
; EXPLANATION: Architectural configuration register inside Device 18, Function 0 
; logging whether factory-level hardware error injection mechanisms are disabled or active.
; ------------------------------------------------------------------------------
%define AMD_DF_ERR_INJECT_COORDINATE    0x80009000 ; Shared Data Fabric Base Node
%define AMD_REG_DF_RAS_ERR_INJECT       0x54       ; [READ-ONLY] Read-only verification register monitoring microarchitectural error injection locks


; --- SUBSYSTEM CODENAME: AMD MCA EXTENDED ERROR REPORTING MASK ---
; EXPLANATION: Fused register logging the absolute status of hardware error masks,
; confirming if specific Machine Check banks are structurally blinded or overridden.
; ------------------------------------------------------------------------------
%define AMD_REG_MCA_OVERRIDE_MASK       0x58       ; [READ-ONLY] Fused register displaying active hardware error logging overrides


; --- SUBSYSTEM CODENAME: AMD COHERENCY AND ROUTING LOG DETECTOR ---
; EXPLANATION: Read-only index offset used to passively check if the memory and core 
; interconnect routing protocols are logging internal hardware transactions correctly.
; ------------------------------------------------------------------------------
%define AMD_REG_DF_COHERENCY_LOG_STATUS 0x5C       ; [READ-ONLY] Read-only capabilities indicator for global fabric transaction monitoring

; ==============================================================================
; 🛰️ CATEGORY 29: AMD SMU FIRMWARE MAILBOX & SECURE BOOT STATUS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware status gates recording core SMU 
; firmware inter-process communication handshakes and Secure Boot verification stages.
; These constants enable the SMM layer to passive-scan internal command routing 
; lines to ensure that pre-boot hardware roots of trust remain structurally uncompromised.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD SMU FIRMWARE INTER-PROCESS MAILBOX STATUS ---
; EXPLANATION: Architectural configuration register inside Device 18, Function 0 
; tracking the absolute response readiness and lock status of internal firmware commands.
; ------------------------------------------------------------------------------
%define AMD_DF_SMU_MAILBOX_COORDINATE   0x80000000 ; Shared Host/Northbridge Routing Base
%define AMD_REG_SMU_FW_CMD_STATUS       0xE0       ; [READ-ONLY] Read-only verification register monitoring microarchitectural mailbox state masks


; --- SUBSYSTEM CODENAME: AMD SECURE BOOT INTEGRITY HANDSHAKE MAP ---
; EXPLANATION: Fused register logging whether physical hardware secure boot state-machines 
; and signature checks successfully fused and locked the hardware initialization flow.
; ------------------------------------------------------------------------------
%define AMD_REG_SECURE_BOOT_HANDSHAKE   0xE4       ; [READ-ONLY] Fused register displaying active pre-boot platform trust anchors


; --- SUBSYSTEM CODENAME: AMD SILICON PRIVACY FILTER MONITOR ---
; EXPLANATION: Read-only index offset used to passively check if the embedded hardware 
; crypto boundaries and access restriction filters on internal firmware lanes are armed.
; ------------------------------------------------------------------------------
%define AMD_REG_SMU_PRIVACY_FILTER_STAT 0xE8       ; [READ-ONLY] Read-only capabilities indicator for global hardware isolation monitoring

; ==============================================================================
; 🔐 CATEGORY 30: AMD CRYPTO ACCELERATION ENGINES & HARDWARE KEY VAULTS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware cryptographic acceleration modules 
; and embedded secure key vault interface registers mapped within the AMD topology.
; These constants enable the SMM layer to passive-scan encryption pipeline flags 
; and hardware-level isolation status registers to ensure absolute key safety.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD HARDWARE CRYPTO ENGINE AUDIT (NODE 0, FUNCTION 5) ---
; EXPLANATION: Dedicated architectural register block inside Device 18, Function 5 
; mapping the raw availability and operational readiness of fused SHA/AES hardware pipelines.
; ------------------------------------------------------------------------------
%define AMD_DF_CRYPTO_CAP_COORDINATE    0x80009500 ; Shared Data Fabric Security Node Base
%define AMD_REG_DF_CRYPTO_STATUS_MASK   0x54       ; [READ-ONLY] Read-only verification register monitoring cryptographic pipeline activation


; --- SUBSYSTEM CODENAME: AMD SECURE KEY VAULT HARDWARE INTERFACE ---
; EXPLANATION: Fused register tracking the status of hardware key slots and fTPM 
; memory-mapped registers, confirming if the master platform encryption flags are armed.
; ------------------------------------------------------------------------------
%define AMD_REG_KEY_VAULT_ISOLATION     0x58       ; [READ-ONLY] Fused register displaying active physical hardware slot containment


; --- SUBSYSTEM CODENAME: AMD SILICON ENCRYPTION PERIPHERAL FENCE ---
; EXPLANATION: Read-only index offset used to passively check if the memory-mapped 
; encryption boundaries and access restrictions on the main platform interfaces are locked.
; ------------------------------------------------------------------------------
%define AMD_REG_CRYPTO_FENCE_STATUS     0x5C       ; [READ-ONLY] Read-only capabilities indicator for global encryption interface monitoring

; ==============================================================================
; 🚌 CATEGORY 31: AMD EXTENDED DATA FABRIC LOGIC & ROUTING CREDIT MAPS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the extended hardware routing parameters and dynamic 
; token buffers mapped within Function 8 of the central AMD Data Fabric node.
; These constants enable the SMM layer to passive-scan cross-fabric transaction
; buffers and credit allocations to safeguard interconnect data stream timing.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD EXTENDED DATA FABRIC CONTROLLER (NODE 0, FUNCTION 8) ---
; EXPLANATION: Dedicated architectural register block inside Device 18, Function 8
; managing the physical flow limits and buffer routing states across chiplet links.
; ------------------------------------------------------------------------------
%define AMD_DF_EXT_LOGIC_COORDINATE     0x80009800 ; Bus 0, Device 18, Function 8 (DF Extended Controller)
%define AMD_REG_DF_TOKEN_BUFFER_CAPS    0x44       ; [READ-ONLY] Read-only verification register monitoring internal transaction token allocation


; --- SUBSYSTEM CODENAME: AMD CROSS-FABRIC ROUTING CREDIT MASTER ---
; EXPLANATION: Fused register logging active credit handshakes between the computing 
; complexes (CCD) and the local I/O hub to regulate system-wide pipeline pressure.
; ------------------------------------------------------------------------------
%define AMD_REG_FABRIC_CREDIT_STATUS    0x48       ; [READ-ONLY] Fused register displaying active hardware flow control thresholds


; --- SUBSYSTEM CODENAME: AMD FABRIC STALL AND DELAY MONITOR ---
; EXPLANATION: Read-only index offset used to passively check if the memory and core 
; transaction links are experiencing artificial delays or timing manipulation attempts.
; ------------------------------------------------------------------------------
%define AMD_REG_FABRIC_STALL_INDICATOR  0x4C       ; [READ-ONLY] Read-only capabilities indicator for structural interconnect health monitoring

; ==============================================================================
; 🚌 CATEGORY 32: AMD SYSTEM CONFIGURATION STATUS & TOPOLOGY ENFORCEMENTS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the final hardware topology verification parameters and 
; core state configuration metrics mapped within Function 9 of Device 18.
; These constants enable the SMM layer to passive-scan system configuration registers
; and verify that the physical boundaries of the processor node remain uncompromised.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD DATA FABRIC CONFIGURATION MASTER (NODE 0, FUNCTION 9) ---
; EXPLANATION: Dedicated architectural register block inside Device 18, Function 9
; logging the master system layout, active node indexes, and global operational caps.
; ------------------------------------------------------------------------------
%define AMD_DF_SYS_CONFIG_COORDINATE    0x80009900 ; Bus 0, Device 18, Function 9 (DF System Config Node)
%define AMD_REG_DF_SYS_CONFIG_STATUS    0x40       ; [READ-ONLY] Read-only verification register monitoring microarchitectural node layouts


; --- SUBSYSTEM CODENAME: AMD PHYSICAL SILICON TOPOLOGY MAP ---
; EXPLANATION: Fused register logging the exact hardware-enforced topology configuration 
; of active processing cores and memory channels established during the silicon bake.
; ------------------------------------------------------------------------------
%define AMD_REG_SILICON_TOPOLOGY_ENF     0x44       ; [READ-ONLY] Fused register displaying active core cluster boundary metrics


; --- SUBSYSTEM CODENAME: AMD INTERCONNECT ROUTING CONTROL WINDOW ---
; EXPLANATION: Read-only capability register tracking internal fabric address range assignments 
; to ensure that memory-mapped hardware lines cannot be dynamically shifted or diverted.
; ------------------------------------------------------------------------------
%define AMD_REG_INTERCONNECT_ROUTING_EN  0x48       ; [READ-ONLY] Read-only capabilities indicator for global silicon address routing

; ==============================================================================
; 🗺️ CATEGORY 33: AMD FABRIC MEMORY MAP & DRAM HOLE ENFORCEMENTS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware DRAM hole apertures and base fabric
; memory map configuration limits embedded within Function 0 of Device 18.
; These constants enable the SMM layer to passive-scan architectural hardware 
; memory boundaries and prevent advanced memory redirection or aliasing bypasses.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD DRAM HOLE ACCESS CONTROLLER (NODE 0, FUNCTION 0) ---
; EXPLANATION: Architectural register block defining the exact start, end, and 
; enablement status of the physical hardware memory hole below the 4GB boundary.
; ------------------------------------------------------------------------------
%define AMD_DF_MEM_MAP_COORDINATE       0x80009000 ; Shared Data Fabric Base Node
%define AMD_REG_DF_DRAM_HOLE_CONTROL    0x94       ; [READ-ONLY] Read-only verification register monitoring architectural DRAM hole apertures


; --- SUBSYSTEM CODENAME: AMD FABRIC BASE ADDRESS REGISTER MAP ---
; EXPLANATION: Fused register logging the static base configurations and routing 
; thresholds assigned to systemic memory-mapped I/O (MMIO) and local system resources.
; ------------------------------------------------------------------------------
%define AMD_REG_FABRIC_MMIO_BASE        0x98       ; [READ-ONLY] Fused register displaying active hardware MMIO base boundaries


; --- SUBSYSTEM CODENAME: AMD HIGH-LIMIT MEMORY APERTURE DETECTOR ---
; EXPLANATION: Read-only capability register tracking the absolute upper boundaries 
; of physical DRAM translation to ensure address decoding spaces remain structurally frozen.
; ------------------------------------------------------------------------------
%define AMD_REG_FABRIC_MEM_HIGH_LIMIT   0x9C       ; [READ-ONLY] Read-only capabilities indicator for global memory map telemetry

; ==============================================================================
; 💾 CATEGORY 34: AMD EXTENDED SPI SECURITY MATRIX & BOOT-ROM INTERCEPTS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the advanced physical hardware security configuration registers 
; inside the embedded SPI/eSPI controller. These constants enable the SMM layer 
; to passive-scan extended firmware fetch controls, verification logs, and 
; silicon-level Boot-ROM isolation gates to ensure complete firmware containment.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD EXTENDED FIRMWARE ACCESS CONTROL (SPI BASE) ---
; EXPLANATION: Architectural register block within Bus 0, Device 31, Function 0
; logging whether extended hardware restrictions on SPI range decoding are locked.
; ------------------------------------------------------------------------------
%define AMD_FCH_SPI_EXT_COORDINATE      0x8000F800 ; Aligned with the physical LPC/eSPI Hub base routing
%define AMD_REG_SPI_EXT_CONFIG_STATUS   0xA8       ; [READ-ONLY] Read-only verification register monitoring microarchitectural access limits


; --- SUBSYSTEM CODENAME: AMD BOOT-ROM INTEGRITY VERIFICATION LOG ---
; EXPLANATION: Fused register logging whether physical hardware secure boot state-machines 
; successfully validated the initial silicon-level Boot-ROM codes at power-on.
; ------------------------------------------------------------------------------
%define AMD_REG_BOOT_ROM_INTEGRITY_FLAG 0xAC       ; [READ-ONLY] Fused register displaying active hardware authentication parameters


; --- SUBSYSTEM CODENAME: AMD SPI COMMAND READ-ONLY INTERCEPT MASTER ---
; EXPLANATION: Read-only capability register tracking if firmware cycle filters 
; are armed to prevent malicious low-level commands from reaching the Flash pins.
; ------------------------------------------------------------------------------
%define AMD_REG_SPI_CMD_FILTER_STATUS   0xB0       ; [READ-ONLY] Read-only capabilities indicator for global flash interface monitoring

; ==============================================================================
; ⚙️ CATEGORY 35: AMD HOST SMBus CONTROL & SFDP PARAMETERS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware status configuration registers inside
; the SMBus controller and the extended Serial Flash Discoverable Parameters (SFDP).
; These constants enable the SMM layer to passive-scan internal communication bounds,
; verify silicon capabilities, and monitor flash description profiles.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD SMBus CONTROLLER CAPABILITIES INTERFACE ---
; EXPLANATION: Architectural register block within Bus 0, Device 31, Function 2
; logging whether specific hardware restrictions on peripheral decoding are locked.
; ------------------------------------------------------------------------------
%define AMD_SMBUS_CAPS_COORDINATE       0x8000F810 ; Aligned with the physical SMBus controller base routing
%define AMD_REG_SMBUS_REVISION_ID       0x08       ; [READ-ONLY] Read-only verification register monitoring microarchitectural silicon steps


; --- SUBSYSTEM CODENAME: AMD SFDP DISCOVERY PARAMETERS MASK ---
; EXPLANATION: Fused register logging whether physical flash definition structures 
; successfully exposed the hardwired memory boundaries and timing profiles at power-on.
; ------------------------------------------------------------------------------
%define AMD_REG_SFDP_DISCOVERY_MASK     0x40       ; [READ-ONLY] Fused register displaying active hardware specification properties


; --- SUBSYSTEM CODENAME: AMD DEVICE ID COMPATIBILITY RADAR ---
; EXPLANATION: Read-only capability register tracking if subsystem device identifiers 
; are structurally locked to prevent peripheral spoofing from compromising the host.
; ------------------------------------------------------------------------------
%define AMD_REG_SUB_DEVICE_COMPAT       0x2C       ; [READ-ONLY] Read-only capabilities indicator for subsystem matrix auditing

; ==============================================================================
; 🔐 CATEGORY 37: AMD PLATFORM FIRMWARE RESILIENCE (PFR) & HARDWARE ROOT OF TRUST (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware platform firmware resilience (PFR)
; status arrays and cryptographic trust anchors embedded inside the FCH complex.
; These constants enable the SMM layer to passive-scan supply chain security links
; and hardware-level boot validation chains to ensure absolute firmware sovereignty.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD PFR MASTER VERIFICATION MATRIX (NODE 0, FUNCTION 0) ---
; EXPLANATION: Architectural configuration register inside Device 31, Function 0
; logging whether the physical Platform Firmware Resilience infrastructure is armed.
; ------------------------------------------------------------------------------
%define AMD_FCH_PFR_COORDINATE          0x8000F800 ; Aligned with the physical LPC/eSPI Hub base routing
%define AMD_REG_PFR_SECURITY_STATUS     0xEC       ; [READ-ONLY] Read-only verification register monitoring microarchitectural boot validation locks


; --- SUBSYSTEM CODENAME: AMD SUPPLY CHAIN TRUST VALIDATION ANCHOR ---
; EXPLANATION: Fused register logging whether physical hardware signature chains
; and microcode anti-rollback mechanisms successfully fused and locked the boot flow.
; ------------------------------------------------------------------------------
%define AMD_REG_TRUST_ANCHOR_FLAG       0xF0       ; [READ-ONLY] Fused register displaying active manufacturing platform protection profiles


; --- SUBSYSTEM CODENAME: AMD FIRMWARE ANTI-ROLLBACK INTERCEPT WINDOW ---
; EXPLANATION: Read-only capability register tracking if firmware version counters
; are structurally locked to prevent malicious downgrade attacks from compromising the host.
; ------------------------------------------------------------------------------
%define AMD_REG_FIRMWARE_VERSION_LOCK   0xF4       ; [READ-ONLY] Read-only capabilities indicator for global anti-rollback telemetry

; ==============================================================================
; 🚌 CATEGORY 38: AMD PCIe GEN 5 ADVANCED ERROR REPORTING (AER) & MARGINING (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware PCIe Gen 5 Advanced Error Reporting (AER)
; matrices and embedded lane margining status indicators inside the AMD PCIe Root Complex.
; These constants enable the SMM layer to passive-scan hardware link training status,
; signal integrity faults, and device synchronization thresholds to block physical DMA bypasses.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD PCIE AER MATRIX CONTROLLER (READ-ONLY) ---
; EXPLANATION: Dedicated architectural register block inside Device 1, Function 0 
; responsible for counting and logging hardware-level errors across high-speed PCIe links.
; ------------------------------------------------------------------------------
%define AMD_PCIE_AER_COORDINATE         0x80000800 ; Primary PCIe Root Port 0 Base
%define AMD_REG_PCIE_AER_UNCORR_STATUS  0x0104     ; [READ-ONLY] Read-only verification register monitoring uncorrectable PCIe link error masks


; --- SUBSYSTEM CODENAME: AMD PCIE GEN 5 LINK TRAINING AND STATUS MAP ---
; EXPLANATION: Fused register logging whether physical hardware link training and status
; successfully stabilized the PCIe width and negotiation steps with attached expansion devices.
; ------------------------------------------------------------------------------
%define AMD_REG_PCIE_LINK_TRAINING_FLAG 0x0110     ; [READ-ONLY] Fused register displaying active physical link capabilities and training status


; --- SUBSYSTEM CODENAME: AMD PCIE PHY LANE MARGINING MONITOR ---
; EXPLANATION: Read-only capability register tracking if physical lane voltage margins 
; and horizontal clock shifts are experiencing hardware-level signal fluctuations or tampering.
; ------------------------------------------------------------------------------
%define AMD_REG_PCIE_MARGIN_CAP_STATUS  0x0114     ; [READ-ONLY] Read-only capabilities indicator for global physical layer interface monitoring

; ==============================================================================
; 🔐 CATEGORY 39: AMD SME STATUS & ASID FUSING LAYOUTS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware encryption status configurations and 
; core Address Space Identifier (ASID) allocation metrics inside the AMD Security Fabric.
; These constants enable the SMM layer to passive-scan memory page encryption flags 
; and hardware-level isolation layouts to ensure absolute defense against physical memory snooping.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD SME HARDWARE ENFORCEMENT CONFIG (NODE 0, FUNCTION 5) ---
; EXPLANATION: Dedicated architectural register block inside Device 18, Function 5 
; responsible for displaying the real-time active memory page encryption validation flags.
; ------------------------------------------------------------------------------
%define AMD_DF_SME_VALIDATION_COORDINATE 0x80009500 ; Shared Data Fabric Security Node Base
%define AMD_REG_DF_SME_PAGE_LOCK_STATUS  0x50       ; [READ-ONLY] Read-only verification register monitoring hardware-level memory encryption state


; --- SUBSYSTEM CODENAME: AMD ASID STRUCTURAL ALLOCATION MATRIX ---
; EXPLANATION: Fused register logging whether physical hardware encryption keys 
; and secure core isolation boundaries successfully separated guest and host address domains.
; ------------------------------------------------------------------------------
%define AMD_REG_ASID_ISOLATION_METRICS   0x58       ; [READ-ONLY] Fused register displaying active hardware ASID scaling capabilities


; --- SUBSYSTEM CODENAME: AMD MEMORY CRYPTO FENCE LOCK REGISTER ---
; EXPLANATION: Read-only index offset used to passively check if the memory controllers 
; encryption barriers and physical hardware access gates are armed against raw data leaks.
; ------------------------------------------------------------------------------
%define AMD_REG_MEM_CRYPTO_FENCE_STATUS  0x5C       ; [READ-ONLY] Read-only capabilities indicator for global memory encryption boundaries

; ==============================================================================
; ⚙️ CATEGORY 40: AMD HARDWARE SECURITY TESTING CONTROL & BIST MONITORS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware Built-In Self-Test (BIST) logs and
; factory silicon debug lock status registers mapped within the AMD FCH/Host matrix.
; These constants enable the SMM layer to passive-scan hardware testing modes
; and ensure that the manufacturers silicon debug gateways remain permanently frozen.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FACTORY DEBUG GATEWAY LOCK (NODE 0, FUNCTION 0) ---
; EXPLANATION: Architectural configuration register inside Device 0, Function 0 
; logging whether structural hardware-level debug windows (JTAG/HDT) are disabled.
; ------------------------------------------------------------------------------
%define AMD_DF_DEBUG_LOCK_COORDINATE    0x80000000 ; Shared Host/Northbridge Routing Base
%define AMD_REG_DF_FACTORY_LOCK_STATUS  0xE8       ; [READ-ONLY] Read-only verification register monitoring factory hardware debug locks


; --- SUBSYSTEM CODENAME: AMD BIST INTEGRITY TESTING COUNTER ---
; EXPLANATION: Fused register logging whether physical hardware built-in self-tests 
; and execution alignment checks successfully verified the chip topology at power-on.
; ------------------------------------------------------------------------------
%define AMD_REG_BIST_INTEGRITY_FLAG     0xEC       ; [READ-ONLY] Fused register displaying active hardware authentication parameters


; --- SUBSYSTEM CODENAME: AMD SILICON TEST INTERACTION FENCE ---
; EXPLANATION: Read-only index offset used to passively check if the memory and core 
; hardware-level test loops are completely isolated from runtime execution layers.
; ------------------------------------------------------------------------------
%define AMD_REG_TEST_INTERFACE_FENCE    0xF0       ; [READ-ONLY] Read-only capabilities indicator for global hardware test monitoring

; ==============================================================================
; 🚌 CATEGORY 41: AMD PCIE NTB & HOT-PLUG LINE MONITORS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware Non-Transparent Bridge (NTB) windows
; and extended hot-plug line status indicators mapped inside the AMD Root Port matrix.
; These constants enable the SMM layer to passive-scan cross-domain address ranges,
; bus training states, and dynamic interface synchronization to block hardware-level bypasses.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD PCIE NTB WINDOW CONTROLLER (READ-ONLY) ---
; EXPLANATION: Dedicated architectural register block inside Device 1, Function 1 
; responsible for mapping and logging the bounds of the isolated non-transparent bridge.
; ------------------------------------------------------------------------------
%define AMD_PCIE_NTB_COORDINATE         0x80000900 ; Bus 0, Device 1, Function 1 Base
%define AMD_REG_PCIE_NTB_BAR_LIMIT      0x0010     ; [READ-ONLY] Read-only verification register monitoring memory apertures for NTB mappings


; --- SUBSYSTEM CODENAME: AMD PCIE HOT-PLUG DETECTOR & SLOT STATUS MAP ---
; EXPLANATION: Fused register logging real-time physical status of slot line triggers, 
; confirming if unexpected hardware connection or disconnection signals occurred on the lanes.
; ------------------------------------------------------------------------------
%define AMD_REG_PCIE_HOTPLUG_STATUS     0x005A     ; [READ-ONLY] Fused register displaying active link slot capability and connection flags


; --- SUBSYSTEM CODENAME: AMD PCIE CROSS-DOMAIN ROUTING BUFFER INTERCEPT ---
; EXPLANATION: Read-only capability register tracking if data transaction queues 
; between isolated fabric domains are structurally confined to prevent inter-domain memory leaks.
; ------------------------------------------------------------------------------
%define AMD_REG_CROSS_DOMAIN_BUFFER_ST  0x0060     ; [READ-ONLY] Read-only capabilities indicator for global domain routing monitoring

; ==============================================================================
; 🚌 CATEGORY 42: AMD SMN SECURE ACCESS GATES & LOCAL MANAGEMENT NODES (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware System Management Network (SMN) 
; secure access gates and localized management interface status configurations.
; These constants enable the SMM layer to passive-scan internal security filters
; and verify that the isolation boundaries of the management matrix remain frozen.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD SMN SECURE ACCESS FILTER (NODE 0, FUNCTION 0) ---
; EXPLANATION: Dedicated architectural register block inside Device 18, Function 0
; responsible for displaying the real-time active SMN hardware-level access restrictions.
; ------------------------------------------------------------------------------
%define AMD_DF_SMN_GATE_COORDINATE      0x80009000 ; Shared Data Fabric Base Node
%define AMD_REG_DF_SMN_GATE_STATUS      0x7C       ; [READ-ONLY] Read-only verification register monitoring microarchitectural access limits


; --- SUBSYSTEM CODENAME: AMD LOCAL MANAGEMENT NODE SECURITY MAP ---
; EXPLANATION: Fused register logging whether physical hardware access restriction filters
; successfully isolated the core configuration loops from runtime execution layers.
; ------------------------------------------------------------------------------
%define AMD_REG_MGMT_NODE_ISOLATION_FLG 0x80       ; [READ-ONLY] Fused register displaying active local management node security status


; --- SUBSYSTEM CODENAME: AMD MANAGEMENT TRAFFIC DECODE CONTROL ---
; EXPLANATION: Read-only capability register tracking if internal hardware command windows
; are structurally confined to prevent unauthorized cross-talk between secure sub-systems.
; ------------------------------------------------------------------------------
%define AMD_REG_MGMT_DECODE_CONTROL_ST  0x84       ; [READ-ONLY] Read-only capabilities indicator for global traffic routing monitoring

; ==============================================================================
; 🧠 CATEGORY 43: AMD UMC POWER GATING & DDR5 PHY CONTROL (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware Unified Memory Controller (UMC) power 
; gating thresholds and DDR5 physical layer (PHY) interface configuration logs.
; These constants enable the SMM layer to passive-scan memory channel clock sync
; and trace signal integrity parameters to secure core DRAM link boundaries.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD UMC POWER GATING CONFIG (NODE 0, FUNCTION 4) ---
; EXPLANATION: Dedicated architectural register block inside Device 18, Function 4
; responsible for displaying real-time microarchitectural memory channel power gating masks.
; ------------------------------------------------------------------------------
%define AMD_DF_UMC_PWR_GATE_COORDINATE  0x80009400 ; Unified Memory Controller Config Base
%define AMD_REG_DF_UMC_PWR_GATE_STATUS  0x74       ; [READ-ONLY] Read-only verification register monitoring memory interface power states


; --- SUBSYSTEM CODENAME: AMD DDR5 PHY LINK SYNC INTERFACE ---
; EXPLANATION: Fused register logging whether physical hardware memory channel clock ratios
; and horizontal signal synchronization loops successfully stabilized the motherboard memory traces.
; ------------------------------------------------------------------------------
%define AMD_REG_DDR5_PHY_SYNC_FLAG      0x78       ; [READ-ONLY] Fused register displaying active DDR5 physical layer interface status

; ==============================================================================
; 🔐 CATEGORY 44: AMD CRYPTO ACCELERATION MONITORS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware crypto co-processor capability logs
; and integrated SHA/AES acceleration pipelines within the AMD Security Fabric.
; These constants enable the SMM layer to passive-scan encryption metrics
; and verify that the microarchitectural isolation boundaries remain frozen.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD CRYPTO ENGINES STATUS (NODE 0, FUNCTION 5) ---
; EXPLANATION: Dedicated architectural register block inside Device 18, Function 5
; responsible for displaying real-time microarchitectural crypto engine activation masks.
; ------------------------------------------------------------------------------
%define AMD_DF_CRYPTO_MON_COORDINATE    0x80009500 ; Data Fabric Security Node Base
%define AMD_REG_DF_CRYPTO_CAP_STATUS    0x40       ; [READ-ONLY] Read-only verification register monitoring cryptographic pipeline readiness


; --- SUBSYSTEM CODENAME: AMD FUSED SECURE PIPELINE HANDSHAKE ---
; EXPLANATION: Fused register logging whether physical hardware encryption keys
; and hardware-level isolation loops successfully stabilized the encryption handshake.
; ------------------------------------------------------------------------------
%define AMD_REG_CRYPTO_HANDSHAKE_FLAG   0x44       ; [READ-ONLY] Fused register displaying active encryption engine pipeline status


; --- SUBSYSTEM CODENAME: AMD CRYPTO ENGINE PERFORMANCE COMPLIANCE ---
; EXPLANATION: Read-only capability register tracking if the crypto co-processors
; hardware-level performance scales or processing lines are experiencing dynamic variations.
; ------------------------------------------------------------------------------
%define AMD_REG_CRYPTO_COMPLIANCE_STAT  0x48       ; [READ-ONLY] Read-only capabilities indicator for global cryptographic auditing


; --- SUBSYSTEM CODENAME: AMD MEMORY INTERFACE DRIVE STRENGTH MONITOR ---
; EXPLANATION: Read-only capability register tracking if the memory controllers 
; electrical drive strengths and impedance boundaries are experiencing hardware-level tampering.
; ------------------------------------------------------------------------------
%define AMD_REG_MC_DRIVE_STRENGTH_STAT  0x7C       ; [READ-ONLY] Read-only capabilities indicator for global memory interface auditing

; ==============================================================================
; 🚌 CATEGORY 45: AMD FABRIC CONFIGURATION NODES & ROUTE SELECTION (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the advanced internal interconnect route selection matrices
; and die-to-die (CCD-to-IOD) hardware link capacities mapped within Function 7 of Device 18.
; These constants enable the SMM layer to passive-scan internal network fabric setups
; and verify that the cross-chiplet communication parameters remain structurally frozen.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FABRIC ROUTE SELECTION CONTROLLER (NODE 0, FUNCTION 7) ---
; EXPLANATION: Dedicated architectural register block inside Device 18, Function 7
; managing the physical route configurations and systemic inter-die line selections.
; ------------------------------------------------------------------------------
%define AMD_DF_ROUTE_SELECT_COORDINATE  0x80009700 ; Bus 0, Device 18, Function 7 (DF Route Selection Node)
%define AMD_REG_DF_ROUTE_SEL_STATUS     0x40       ; [READ-ONLY] Read-only verification register monitoring interconnect path configurations


; --- SUBSYSTEM CODENAME: AMD DIE-TO-DIE LINK CAPACITY MASTER MAP ---
; EXPLANATION: Fused register logging the exact hardware-enforced link bandwidth metrics
; and queue capacities allocated between separate silicon chiplets during runtime.
; ------------------------------------------------------------------------------
%define AMD_REG_DIE_LINK_CAPACITY_ENF   0x44       ; [READ-ONLY] Fused register displaying active link performance thresholds


; --- SUBSYSTEM CODENAME: AMD INTERNAL FABRIC TRAFFIC BALANCE REGISTER ---
; EXPLANATION: Read-only capability register tracking if dynamic load balancing matrices
; on internal routing lanes are structurally operating within secure performance bounds.
; ------------------------------------------------------------------------------
%define AMD_REG_FABRIC_BALANCE_STATUS   0x48       ; [READ-ONLY] Read-only capabilities indicator for global fabric health monitoring

; ==============================================================================
; 🚌 CATEGORY 46: AMD DATA FABRIC LINK TRAINING & WIDTH MONITORS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware inter-die fabric link training states
; and microarchitectural bus width status indicators mapped within Device 19, Function 1.
; These constants enable the SMM layer to passive-scan internal chiplet link health
; and trace signal integrity parameters to verify that the core communication grid remains stable.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FABRIC LINK TRAINING CONTROLLER (NODE 0, FUNCTION 1) ---
; EXPLANATION: Dedicated architectural register block inside Device 19, Function 1
; responsible for displaying real-time link training readiness and active width parameters.
; ------------------------------------------------------------------------------
%define AMD_DF_LINK_TRAIN_COORDINATE    0x80009900 ; Device 19 (0x13), Function 1 (Fabric Link Tracking Node)
%define AMD_REG_DF_LINK_TRAIN_STATUS    0x40       ; [READ-ONLY] Read-only verification register monitoring microarchitectural link status


; --- SUBSYSTEM CODENAME: AMD INTER-DIE TRANSACTION CREDIT MAP ---
; EXPLANATION: Fused register logging whether physical hardware link buffer credits
; and horizontal synchronization parameters successfully stabilized the core inter-die lanes.
; ------------------------------------------------------------------------------
%define AMD_REG_INTERDIE_CREDIT_FLAG    0x44       ; [READ-ONLY] Fused register displaying active transaction link buffer allocations


; --- SUBSYSTEM CODENAME: AMD FABRIC SIGNAL INTEGRITY FAULT INTERCEPT ---
; EXPLANATION: Read-only capability register tracking if internal hardware link width
; or clock synchronization loops are experiencing structural fluctuations or hardware-level tampering.
; ------------------------------------------------------------------------------
%define AMD_REG_FABRIC_FAULT_INDICATOR  0x48       ; [READ-ONLY] Read-only capabilities indicator for global fabric interface monitoring

; ==============================================================================
; 🚌 CATEGORY 47: AMD DATA FABRIC LINK COHERENCY CONTROL & PROBE FILTERS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the advanced hardware cache coherency protocols and dynamic 
; probe filters mapped within Function 2 of the extended AMD Data Fabric node.
; These constants enable the SMM layer to passive-scan cross-chiplet coherency directories
; and tracking buffers to safeguard multi-core interconnect transaction timing.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FABRIC COHERENCY CONTROLLER (NODE 0, FUNCTION 2) ---
; EXPLANATION: Dedicated architectural register block inside Device 19, Function 2
; responsible for displaying real-time probe filter enablement and directory validation masks.
; ------------------------------------------------------------------------------
%define AMD_DF_COHERENCY_EXT_COORDINATE 0x80009A00 ; Device 19 (0x13), Function 2 (Fabric Coherency Tracking Node)
%define AMD_REG_DF_PROBE_FILTER_STATUS  0x40       ; [READ-ONLY] Read-only verification register monitoring microarchitectural filter states


; --- SUBSYSTEM CODENAME: AMD CROSS-CHIPLET DIRECTORY STATUS MAP ---
; EXPLANATION: Fused register logging whether physical hardware cache directory tables
; and tracking capabilities successfully enforce strict line isolation across memory nodes.
; ------------------------------------------------------------------------------
%define AMD_REG_DIRECTORY_ISOLATION_FLG 0x44       ; [READ-ONLY] Fused register displaying active hardware directory allocation flags


; --- SUBSYSTEM CODENAME: AMD FABRIC COHERENCY BUFFER OVERFLOW INTERCEPT ---
; EXPLANATION: Read-only capability register tracking if internal transaction queues
; handle cross-core cache invalidation requests within secure architectural timing limits.
; ------------------------------------------------------------------------------
%define AMD_REG_COHERENCY_LIMIT_STATUS  0x48       ; [READ-ONLY] Read-only capabilities indicator for global coherency monitoring

; ==============================================================================
; 🚌 CATEGORY 48: AMD DATA FABRIC ADVANCED QUEUE MANAGEMENT (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the hardware transaction queues and internal buffer allocation
; matrices mapped within Function 3 of the extended AMD Data Fabric node complex.
; These constants enable the SMM layer to passive-scan internal network buffers
; and latency properties to safeguard interconnect transaction stream timing.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FABRIC QUEUE CONTROLLER (NODE 0, FUNCTION 3) ---
; EXPLANATION: Dedicated architectural register block inside Device 19, Function 3
; responsible for displaying real-time allocation readiness and transaction buffer states.
; ------------------------------------------------------------------------------
%define AMD_DF_QUEUE_EXT_COORDINATE    0x80009B00 ; Device 19 (0x13), Function 3 (Fabric Queue Tracking Node)
%define AMD_REG_DF_BUFFER_ALLOC_STATUS 0x40       ; [READ-ONLY] Read-only verification register monitoring microarchitectural buffer allocations


; --- SUBSYSTEM CODENAME: AMD INTER-CORE LATENCY TRIGGER MAP ---
; EXPLANATION: Fused register logging whether physical hardware latency constraints
; and horizontal packet synchronization parameters successfully stabilized the core inter-die links.
; ------------------------------------------------------------------------------
%define AMD_REG_LATENCY_THRESHOLD_FLAG 0x44       ; [READ-ONLY] Fused register displaying active transaction queue pressure status


; --- SUBSYSTEM CODENAME: AMD FABRIC BUFFER TRAFFIC STALL INTERCEPT ---
; EXPLANATION: Read-only capability register tracking if internal hardware command windows
; handle packet routing delays or scheduling manipulation attempts within secure timing limits.
; ------------------------------------------------------------------------------
%define AMD_REG_TRAFFIC_STALL_STATUS   0x48       ; [READ-ONLY] Read-only capabilities indicator for global fabric queue monitoring

; ==============================================================================
; 🚌 CATEGORY 49: AMD DATA FABRIC ADVANCED ADDRESS TRANSLATION (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the hardware address translation logic and dynamic 
; memory range interleaving properties mapped within Function 4 of Device 19.
; These constants enable the SMM layer to passive-scan internal memory mapping
; parameters and tracking registers to ensure systemic memory isolation.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FABRIC ADDRESS MAPPER (NODE 0, FUNCTION 4) ---
; EXPLANATION: Dedicated architectural register block inside Device 19, Function 4
; responsible for displaying real-time memory range configurations and interleaving masks.
; ------------------------------------------------------------------------------
%define AMD_DF_TRANS_EXT_COORDINATE    0x80009C00 ; Device 19 (0x13), Function 4 (Fabric Translation Tracking Node)
%define AMD_REG_DF_MEM_INTERLEAVE_STAT 0x40       ; [READ-ONLY] Read-only verification register monitoring memory range interleaving structures


; --- SUBSYSTEM CODENAME: AMD PHYSICAL DRAM MAP INTERCEPT ---
; EXPLANATION: Fused register logging whether physical hardware translation configurations
; and address decoding bounds successfully stabilize the active memory controller links.
; ------------------------------------------------------------------------------
%define AMD_REG_DRAM_MAP_VALID_FLAG    0x44       ; [READ-ONLY] Fused register displaying active physical address translation status


; --- SUBSYSTEM CODENAME: AMD FABRIC DECODING EXCLUSION DETECTOR ---
; EXPLANATION: Read-only capability register tracking if internal hardware memory apertures
; handle exclusion zones or secure memory windows within safe structural boundaries.
; ------------------------------------------------------------------------------
%define AMD_REG_DECODE_EXCLUSION_STAT  0x48       ; [READ-ONLY] Read-only capabilities indicator for global memory translation monitoring

; ==============================================================================
; 🔐 CATEGORY 50: AMD HARDWARE SECURITY POLICY ENFORCEMENT & MASTER FUSING (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the final hardware-enforced security policy engines and 
; master factory fusing configuration matrices mapped within Function 5 of Device 19.
; These constants enable the SMM layer to passive-scan memory page validation states
; and verify that the hardware-level encryption policies remain structurally frozen.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FABRIC SECURITY POLICY ENFORCER (NODE 0, FUNCTION 5) ---
; EXPLANATION: Dedicated architectural register block inside Device 19, Function 5
; responsible for displaying real-time hardware-enforced SME/SEV page validation locks.
; ------------------------------------------------------------------------------
%define AMD_DF_SEC_POLICY_COORDINATE    0x80009D00 ; Device 19 (0x13), Function 5 (Fabric Security Tracking Node)
%define AMD_REG_DF_PAGE_VALIDATION_STAT 0x40       ; [READ-ONLY] Read-only verification register monitoring microarchitectural policy locks


; --- SUBSYSTEM CODENAME: AMD FACTORY FUSING PRODUCTION MASTER MATRIX ---
; EXPLANATION: Fused register logging whether physical hardware manufacturing security fuses
; and core silicon isolation filters successfully sealed the platform deployment profile.
; ------------------------------------------------------------------------------
%define AMD_REG_MASTER_FUSING_FLAG      0x44       ; [READ-ONLY] Fused register displaying active manufacturing security status


; --- SUBSYSTEM CODENAME: AMD HARDWARE ENCRYPTION CONTROL POLICY MASTER ---
; EXPLANATION: Read-only capability register tracking if internal hardware memory apertures
; handle crypto validation boundaries and access fences within secure structural bounds.
; ------------------------------------------------------------------------------
%define AMD_REG_CRYPTO_POLICY_STATUS    0x48       ; [READ-ONLY] Read-only capabilities indicator for global security policy monitoring

; ==============================================================================
; 🛰️ CATEGORY 51: AMD SMU EXTENDED INFRASTRUCTURE & THROTTLING MONITORS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the extended physical hardware System Management Unit (SMU) 
; message ports and integrated thermal throttling state tracking registers.
; These constants enable the SMM layer to passive-scan hardware control channels
; and trace signal parameters to verify that the core energy grid remains stable.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD SMU EXTENDED MESSAGE INTERFACE (NODE 0, FUNCTION 0) ---
; EXPLANATION: Dedicated architectural register block inside Device 0, Function 0
; responsible for displaying real-time microarchitectural message readiness and response masks.
; ------------------------------------------------------------------------------
%define AMD_DF_SMU_EXT_MSG_COORDINATE   0x80000000 ; Shared Host/Northbridge Routing Base
%define AMD_REG_SMU_EXT_MSG_STATUS      0xEC       ; [READ-ONLY] Read-only verification register monitoring microarchitectural mailbox states


; --- SUBSYSTEM CODENAME: AMD THERMAL THROTTLING HARDWARE INTERCEPT ---
; EXPLANATION: Fused register logging whether physical hardware thermal throttling events
; and automatic frequency scaling loops successfully stabilized the chip core power grid.
; ------------------------------------------------------------------------------
%define AMD_REG_THERMAL_THROTTLE_FLAG   0xF0       ; [READ-ONLY] Fused register displaying active microarchitectural heat safety parameters


; --- SUBSYSTEM CODENAME: AMD HARDWARE ISOLATION INTERFACE MONITOR ---
; EXPLANATION: Read-only capability register tracking if internal hardware test loops
; handle encryption boundaries and secure access filters within safe structural bounds.
; ------------------------------------------------------------------------------
%define AMD_REG_SMU_ISOLATION_STATUS    0xF4       ; [READ-ONLY] Read-only capabilities indicator for global hardware isolation monitoring

; ==============================================================================
; 🚌 CATEGORY 52: AMD HARDWARE COHERENT INTERCONNECT COUNTERS & SCHEDULERS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the hardware cache request schedulers and internal link 
; invalidation buffer allocation masks mapped within Function 3 of Device 19.
; These constants enable the SMM layer to passive-scan internal transaction lines
; and link arbitration parameters to safeguard interconnect data stream timing.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FABRIC CACHE REQUEST SCHEDULER (NODE 0, FUNCTION 3) ---
; EXPLANATION: Dedicated architectural register block inside Device 19, Function 3
; responsible for displaying real-time allocation readiness and cache request scheduler states.
; ------------------------------------------------------------------------------
%define AMD_DF_CACHE_SCHED_COORDINATE   0x80009B00 ; Device 19 (0x13), Function 3 (Fabric Queue/Sched Node)
%define AMD_REG_DF_SCHED_ALLOC_STATUS   0x4C       ; [READ-ONLY] Read-only verification register monitoring microarchitectural scheduler allocations


; --- SUBSYSTEM CODENAME: AMD FABRIC LINK INVALIDATION MASK ---
; EXPLANATION: Fused register logging whether physical hardware cache line invalidation 
; and tracking capabilities successfully enforce strict line isolation across fabric loops.
; ------------------------------------------------------------------------------
%define AMD_REG_FABRIC_INVALIDATE_MASK  0x50       ; [READ-ONLY] Fused register displaying active hardware link invalidation thresholds


; --- SUBSYSTEM CODENAME: AMD COHERENT INTERCONNECT PERFORMANCE FACTOR ---
; EXPLANATION: Read-only capability register tracking if internal hardware transaction queues
; handle cross-core request scheduling variations or pacing attempts within secure timing limits.
; ------------------------------------------------------------------------------
%define AMD_REG_INTERCONNECT_PERF_STAT  0x54       ; [READ-ONLY] Read-only capabilities indicator for global link arbitration monitoring

; ==============================================================================
; 🚌 CATEGORY 53: AMD EXTENDED ADDRESS MAPS & EXCLUSION APERTURES (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the hardware memory exclusion apertures and advanced address
; map configurations mapped within Function 4 of the Device 19 fabric complex.
; These constants enable the SMM layer to passive-scan hardware boundaries 
; and ensure that physical flash interfaces and MMIO spaces remain fully isolated.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FABRIC EXTENDED APERTURE CONTROLLER (NODE 0, FUNCTION 4) ---
; EXPLANATION: Dedicated architectural register block inside Device 19, Function 4
; responsible for displaying real-time memory exclusion zones and window capability masks.
; ------------------------------------------------------------------------------
%define AMD_DF_MAP_EXT_COORDINATE       0x80009C00 ; Device 19 (0x13), Function 4 (Fabric Map Node)
%define AMD_REG_DF_EXCLUSION_LIMITS     0x4C       ; [READ-ONLY] Read-only verification register monitoring memory exclusion bounds


; --- SUBSYSTEM CODENAME: AMD PHYSICAL MEMORY MAP BASE BOUNDARY ---
; EXPLANATION: Fused register logging whether physical hardware boundary configurations
; and address decoding zones successfully stabilize the active memory controller links.
; ------------------------------------------------------------------------------
%define AMD_REG_FABRIC_BASE_VALID_FLAG  0x50       ; [READ-ONLY] Fused register displaying active physical address map thresholds


; --- SUBSYSTEM CODENAME: AMD HIGH-Aperture ADDRESS INTERCEPT ---
; EXPLANATION: Read-only capability register tracking if internal hardware memory apertures
; handle data routing windows or scheduling manipulation attempts within secure structural limits.
; ------------------------------------------------------------------------------
%define AMD_REG_HIGH_APERTURE_STATUS    0x54       ; [READ-ONLY] Read-only capabilities indicator for global memory aperture monitoring

; ==============================================================================
; 🚌 CATEGORY 54: AMD EXTENDED DATA FABRIC LINK INTERCONNECTS (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the advanced hardware die-to-die configuration nodes,
; transaction flow optimization matrices, and multi-socket topology metrics
; mapped within Functions 6 and 7 of the extended Device 19 fabric network.
; These constants enable the SMM layer to passive-scan cross-chiplet bus behaviors
; and link routing definitions to enforce absolute data stream isolation.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FABRIC TRANSACTION OPTIMIZER (NODE 0, FUNCTION 6) ---
; EXPLANATION: Dedicated architectural register block inside Device 19, Function 6
; responsible for displaying real-time inter-die buffer scheduling and flow optimization states.
; ------------------------------------------------------------------------------
%define AMD_DF_FLOW_OPT_COORDINATE      0x80009E00 ; Device 19 (0x13), Function 6 (Fabric Flow Control Node)
%define AMD_REG_DF_FLOW_CTRL_STATUS     0x40       ; [READ-ONLY] Read-only verification register monitoring inter-die traffic scheduling


; --- SUBSYSTEM CODENAME: AMD MULTI-SOCKET TOPOLOGY CAPABILITIES (NODE 0, FUNCTION 7) ---
; EXPLANATION: Fused register logging whether physical hardware cross-socket linkage configuration
; and multi-node routing bounds successfully stabilize active cross-package communication domains.
; ------------------------------------------------------------------------------
%define AMD_DF_TOPOLOGY_EXT_COORDINATE  0x80009F00 ; Device 19 (0x13), Function 7 (Fabric Topology Node)
%define AMD_REG_MULTI_NODE_CAPS_FLAG    0x44       ; [READ-ONLY] Fused register displaying active physical node and package routing rules


; --- SUBSYSTEM CODENAME: AMD CHIP_LET ROUTING BUFFER DEFENSE MONITOR ---
; EXPLANATION: Read-only capability register tracking if dynamic load balancing and internal 
; fabric command queues process multi-die transactions within secure architectural timing windows.
; ------------------------------------------------------------------------------
%define AMD_REG_FABRIC_BUFFER_CAP_STAT  0x48       ; [READ-ONLY] Read-only capabilities indicator for global link routing monitoring

; ==============================================================================
; 🚌 CATEGORY 55: AMD DMA SUBSYSTEM CONTROLLERS & DIRECT MEMORY ACCESS BOUNDARIES (READ-ONLY)
; ------------------------------------------------------------------------------
; EXPLANATION: Targets the physical hardware Direct Memory Access (DMA) sub-system 
; controllers and hub-to-host execution boundaries mapped within the AMD FCH layout.
; These constants enable the SMM layer to passive-scan dynamic DMA transactions 
; and trace peripheral memory access fences to eliminate physical hardware-level leaks.
; Mapped as: 0x80000000 | (Bus << 16) | (Device << 11) | (Function << 8)
; ==============================================================================


; --- SUBSYSTEM CODENAME: AMD FCH DMA MASTER HUB CONTROLLER ---
; EXPLANATION: Dedicated architectural register block inside Device 31, Function 0
; responsible for monitoring and logging hardware-level direct memory transfer requests.
; ------------------------------------------------------------------------------
%define AMD_FCH_DMA_HUB_COORDINATE      0x8000F800 ; Aligned within the core LPC/eSPI Hub routing layer
%define AMD_REG_DMA_CHANNEL_STATUS      0xF8       ; [READ-ONLY] Read-only verification register monitoring microarchitectural DMA channel states


; --- SUBSYSTEM CODENAME: AMD PERIPHERAL DMA FENCE VALIDATION ANCHOR ---
; EXPLANATION: Fused register logging whether physical hardware memory range exclusion lists
; and hardware-level isolation loops successfully confined peripheral direct memory access.
; ------------------------------------------------------------------------------
%define AMD_REG_DMA_FENCE_VALID_FLAG    0xFC       ; [READ-ONLY] Fused register displaying active hardware DMA boundary profiles


