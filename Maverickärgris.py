
def Spam(Text, Times):
    for index in range(Times):
        print(Text)
    
i = input("Input: ")
t = int(input("Times: "))
Spam(i, t)
type(t)