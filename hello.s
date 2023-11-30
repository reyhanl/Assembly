.global _main
.align 2 

_print:
    //x0 to x7 is like a parameter that you can use when you call x16
    //in the example below, x0 is the first parameter, and so on
    //user_ssize_t write (int fd, ser _addr_t cbuf, user_size_t nbyte);
    //that is x16, #4 (print). it requires 3 parameter that we can pass using x0-x7. 
    mov x0, #1 //stdout
    adr x1, helloworld //address of hello world string
    mov x2, #12 //pass to x2, so that we got 12 byte string (lenght of hellowworld)
    mov x16, #4 //call to stdout 
    //We pass the 3
    svc 0
_main:
    //Custom loop, x5 for starting number, and x7 for how many times you want 
    //it to be repeated
    Mov x5, #1
    Mov x7, #1 
    b _repeatFrom

    b _terminate
    
_reboot:
    mov x0, #1
    mov x16, #55 //_reboot
    svc 0

_terminate:
    mov x0, #0
    mov x16, #1
    svc 0

_loop: // body of the loop goes here.
// Most of the logic is at the end
    ADD x5, x5, #1 // I = I + 1
    CMP x5, #10 //compare value of w2 with 10
    MOV x0, #1
    ADR x1, helloworld
    MOV x2, #12 //memory
    MOV x16, #4 //print
    SVC 0
    B.LE _loop // IF I <= 10 goto loop

_repeat:
    MOV x0, 1
    ADR x1, helloworld //use adr to get address and store it
    MOV x2, 12
    MOV x16, #4
    ADD x6, x6, 1
    CMP x6, #10
    SVC 0
    B.LE _repeat

_repeatFrom:
    ADD x5, x5, #1
    CMP x5, x7
    MOV x0, #1
    ADR x1, helloworld
    MOV x2, 12
    MOV x16, #4
    SVC 0
    B.LE _repeatFrom

//If we did this by counting down
//FOR I = 10 TO 1 STEP -1
//... some statements...
//NEXT I
//We can implement this as shown in Listing 4-3.

helloworld:
.ascii "hello world \n"
