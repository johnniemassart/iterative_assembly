class Module_10:
        
    # output prime numbers through max loop value
    def is_prime(self):
        max_loop = int(input("Enter a max loop value: "))
        output = "The prime numbers include: "
        for i in range(3, (max_loop + 1)):
            for j in range(2, (max_loop // 2) + 1):
                if i % j == 0 and i != j:
                    break
                elif j == (max_loop // 2):
                    output += f"{i} "
        return output
    
    # determine "secret" number using a binary search
    def guess_num(self):
        output = ""
        num_input = int(input("Enter a max number: "))
        i = 1
        guesses = 0
        while i <= num_input:
            mid = (num_input + i) // 2
            question = input(f"Is the secret number equal to {str(mid)}? Enter Y/N: ")
            if question == "Y":
                guesses += 1
                output += f"The secret number is {str(mid)}. The program required {str(guesses)} guess(es)."
                break
            elif question == "N":
                low_or_high = input("Is the secret number low or high? Enter low/high: ")
                if low_or_high == "low":
                    guesses += 1
                    i = mid + 1
                elif low_or_high == "high":
                    guesses += 1
                    num_input = mid - 1
        return output

mod_10 = Module_10()
# print(mod_10.is_prime())
print(mod_10.guess_num())