.data
	nrCerinta: .space 4
	nrNoduri: .space 4
	noduri: .space 400
	matrice: .space 40000
	matrice2: .space 40000
	matrice3: .space 40000
	fs1: .asciz "%ld"
	fs2: .asciz "%ld "
	fs3: .asciz "%ld \n"
	x: .space 4
	n: .space 4
	k: .space 4
	i: .space 4
	j: .space 4
	nr: .space 4
	counter: .long 0
.text

matrix_mult:
	pushl %ebp
	mov %esp, %ebp
	
	pushl %ebx
	pushl %edi
	pushl %esi
	
	xor %edx, %edx
	mov 20(%ebp), %eax
	mul %eax
	mov $0, %edx
	
	mov 8(%ebp), %edi
	mov 12(%ebp), %esi
	mov 16(%ebp), %ebx
	
	subl $16, %esp
	
	movl $0, -4(%ebp)
	movl $0, -8(%ebp)
	movl $0, -12(%ebp)
	movl $0, -16(%ebp)
	
	et_for1:
		cmp %edx, %eax
		je return
		
		movl $0, (%ebx, %edx, 4)
		mov %edx, -12(%ebp)
		mov %eax, -16(%ebp)
		
		mov $0, %ecx
		
		et_for2:
			cmp 20(%ebp), %ecx
			je next
			
			push %eax
			push %edx
			
			movl $0, -4(%ebp)
			movl $0, -8(%ebp)
			
			mov %edx, -4(%ebp)
			add %ecx, -4(%ebp)
			mov %edx, %eax
			mov $0, %edx
			idivl 20(%ebp)
			sub %edx, -4(%ebp)
			add %edx, -8(%ebp)
			mov -4(%ebp), %eax
			mov (%edi, %eax, 4), %edx
			mov %edx, -4(%ebp)
			
			mov %ecx, %eax
			mov $0, %edx
			imull 20(%ebp)
			add %eax, -8(%ebp)
			mov -8(%ebp), %eax
			mov (%esi, %eax, 4), %edx
			mov %edx, -8(%ebp)
			
			mov -4(%ebp), %eax
			mov $0, %edx
			imull -8(%ebp)
			
			mov -12(%ebp), %edx
			addl %eax, (%ebx, %edx, 4)
			
			pop %eax
			pop %edx
			
			mov -16(%ebp), %eax
			mov -12(%ebp), %edx
			add $1, %ecx
			jmp et_for2
			
				
		next:
			
			mov -16(%ebp), %eax
			mov -12(%ebp), %edx
			add $1, %edx
			jmp et_for1
	return:
	
		popl %ebx
		popl %edi
		popl %esi
		
		addl $16, %esp
		
		popl %ebp
		ret
	
.global main
main:

	pushl $nrCerinta
	pushl $fs1
	call scanf
	popl %ebx
	popl %ebx


	pushl $nrNoduri
	pushl $fs1
	call scanf
	popl %ebx
	popl %ebx
	
	mov nrNoduri, %eax
	mul %eax
	mov $0, %ecx
	lea matrice, %edi
	
zerouri:
	cmp %ecx, %eax
	je next1
	
	movl $0, (%edi, %ecx, 4)
		
	add $1, %ecx
	jmp zerouri

next1:
	mov $0, %ecx
	lea noduri, %edi
	
loop:
	cmp %ecx, nrNoduri
	je next2
		
	push %ecx
	pushl %edi
	pushl $fs1
	call scanf
	popl %ebx
	popl %ebx
	pop %ecx
		
	add $4, %edi
	add $1, %ecx
	jmp loop
next2:
	mov $0, %ecx
	lea noduri, %edi
	lea matrice, %esi
loop2:
	cmp %ecx, nrNoduri 
	je next4
		
	mov (%edi, %ecx, 4), %ebx
	movl $0, counter
		
	loop3:
		cmp counter, %ebx
		je next3
			
		push %ecx
			
		pushl $x
		pushl $fs1
		call scanf
		popl %edx
		popl %edx
		
		pop %ecx
			
		mov $0, %edx
		mov %ecx, %eax
		mull nrNoduri
		addl x, %eax
			
		movl $1, (%esi, %eax, 4)
						
		addl $1, counter
		jmp loop3
	next3:
		add $1, %ecx
		jmp loop2	
next4:
	mov nrNoduri, %eax
	mul %eax
	mov %eax, n
	mov $0, %ecx
	mov $1, %eax
		
	cmpl $1, nrCerinta
	je cerinta1
	jne cerinta2
cerinta1:
	
	afisare:
		cmp n, %ecx
		je exit
		
		cmp nrNoduri, %eax
		je afisare2
		
		push %ecx
		push %eax
			
		mov (%esi, %ecx, 4), %edx
		pushl %edx
		pushl $fs2
		call printf
		popl %ebx
		popl %ebx
		
		pushl $0
		call fflush
		popl %ebx
		
		pop %eax
		pop %ecx
			
		add $1, %ecx
		add $1, %eax
		jmp afisare
	afisare2:
		push %ecx
		
		mov (%esi, %ecx, 4), %edx
		pushl %edx
		pushl $fs3
		call printf
		popl %ebx
		popl %ebx
		
		pushl $0
		call fflush
		popl %ebx
		
		pop %ecx
		
		mov $1, %eax
		add $1, %ecx
		jmp afisare
				
cerinta2:
	pushl $k
	pushl $fs1
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $i
	pushl $fs1
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $j
	pushl $fs1
	call scanf
	popl %ebx
	popl %ebx
	
	mov $0, %ecx
	mov nrNoduri, %eax
	mov $0, %edx
	mul %eax
	mov %eax, nr
	lea matrice, %edi
	lea matrice2, %esi
	
	
	copiere:
		cmp %ecx, nr
		je next5
		
		mov (%edi, %ecx, 4), %edx
		mov %edx, (%esi, %ecx, 4)
		
		add $1, %ecx
		jmp copiere 
	
	next5:
		mov $1, %ecx
		
	ridicare:
		cmp k, %ecx
		je afisare3
		
		push %ecx
		#push %eax
		#push %edx
		
		pushl nrNoduri
		pushl $matrice3
		pushl $matrice2
		pushl $matrice
		call matrix_mult
		popl %ebx
		popl %ebx
		popl %ebx
		popl %ebx
		
		#pop %eax
		pop %ecx
		#pop %edx
		
		mov $0, %ebx
		lea matrice3, %edi
		lea matrice2, %esi
		copiere2:
			cmp %ebx, nr
			je next6
			
			mov (%edi, %ebx, 4), %edx
			mov %edx, (%esi, %ebx, 4)
			
			add $1, %ebx
			jmp copiere2
		
		next6:
			add $1, %ecx
			jmp ridicare
	afisare3:
		
		mov i, %eax
		mov $0, %edx
		mull nrNoduri
		addl j, %eax
		mov (%esi, %eax, 4), %edx
		
		pushl %edx
		pushl $fs1
		call printf
		popl %ebx
		popl %ebx
		
		pushl $0
		call fflush
		popl %ebx
exit:
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
