def process_user_input(user_data):
    # Potential SQL injection vulnerability for CodeQL to find
    query = "SELECT * FROM users WHERE name = '" + user_data + "'"
    
    # Potential command injection vulnerability
    import os
    os.system("echo " + user_data)
    
    # Potential path traversal vulnerability
    with open(user_data, 'r') as file:
        content = file.read()
    
    return query, content

def main():
    user_input = input("Enter username: ")
    result = process_user_input(user_input)
    print(result)

if __name__ == "__main__":
    main()
