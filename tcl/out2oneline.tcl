set input_file "addfile.txt"
set output_file "out.txt"

# 读取文件内容
set file_handle [open $input_file r]
set content [read $file_handle]
close $file_handle

# 移除换行符
set content [string map {\n ""} $content]

# 写入到输出文件
set file_handle [open $output_file w]
puts $file_handle $content
close $file_handle
