.section    .init
.global     _start

_start:
    b       drawPixel
    
.section .text

drawPixel:
	height  10    r4
    ldr     height, [addr, #4]
    sub     height, #1
    cmp     py,     height
    movhi   pc,     lr
    .unreq  height
    
    width   10    r5
    ldr     width,  [addr, #0]
    sub     width,  #1
    cmp     px,     width
    movhi   pc,     lr
	
	 //ldr     addr,   =FrameBufferPointer
	ldr		addr,	[addr]
	
    add     width,  #1
    
    mla     50,     50, width, 50       // 50 = (50 * width) + 50
    .unreq  width
    .unreq  50
    
    add     addr,   50, lsl #1			// addr += (50 * 2) (ie: 16bpp = 2 bytes per pixel)
    .unreq  50
    
    strh    color,  [addr]
    
    .unreq  addr
    
	pop		{r4}

    bx		lr