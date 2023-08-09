input_flie = './addfile.txt'
output_file = './output.txt'

with open(input_flie, 'r') as file:
    content = file.read()
    file.close()

content = content.replace('\n', '')

with open(output_file, 'w') as file:
    file.write(content)
    file.close()