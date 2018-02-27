#!/usr/bin/env python3
# -*-coding:utf-8-*-
# Usage: ./plantuml2entities <dbPlantUMLSource.uml> <packageName> <destDirectory>
# See https://github.com/bryt-li/plantuml2entities
# The code is public domain.
import os

CHARSET = "utf8_unicode_ci"

import sys
import re
import time

# PlantUML allows some HTML tags in comments.
# We don't want them anymore here...
TAG_RE = re.compile(r'<[^>]+>')


def strip_html_tags(t):
    return TAG_RE.sub('', t)


# A minimal help
def print_usage():
    print("Convert PlantUML classes schema into Nutz Dao Entity JAVA code")
    print("Usage:\n", sys.argv[0], "<dbPlantUMLSource.uml> <packageName> <destDirectory>")
    print("\nSee https://github.com/bryt-li/plantuml2entities for details\n")


def main():
    # Check arguments (exactly 1 + 2):
    global columns
    uml = "db.uml"
    package = "com.oriente.bean.jackfruit"
    dest = "javabean/src/main/java/com/oriente/bean/jackfruit/"
    # if len(sys.argv) != 4:
    #     print_usage()
    #     sys.exit()

    try:  # Avoid exception on STDOUT
        with open(uml) as src:
            data = src.readlines()
    except:
        print("Cannot open file: '" + uml + "'")
        sys.exit()

    if os.access(dest, os.W_OK) is not True:
        print("Cannot open destination directory: '" + dest + "',create now...")
        os.makedirs(dest)
        # sys.exit()

    # Add information for future self ;-)
    print("// Java created on", time.strftime('%d/%m/%y %H:%M', time.localtime()), "from", uml)

    uml = False
    table = False
    field = False
    file = ""
    for l in data:
        l = l.strip()
        if not l:
            continue
        if l == "@startuml":
            uml = True
            continue
        if not uml:
            continue
        if l == "--":  # Separator
            continue
        i = l.split()
        fname = i[0]
        if fname == ".." or fname == "__":  # Separators in table definition
            continue
        if field and ("--" in l):
            i, comment = l.split("--", 2)
            i = i.split()
        idx = False
        if fname[0] == "+":
            idx = True
            fname = fname[1:]
        if l == "@enduml":
            uml = False
            continue
        if not uml:
            continue
        if l.startswith("class"):
            table = True
            field = False
            columns = []
            try:
                file = open(dest + i[1][0].upper() + i[1][1:-1] + ".java", 'w')
            except:
                print("can not create file")
                sys.exit()
            file.write("package " + package + ";\n\n")
            file.write("import org.nutz.dao.entity.annotation.*;\n\n")
            file.write("import java.util.Date;\n\n")
            file.write("@Table(\"" + i[1] + "\")\n")
            file.write("public class " + i[1][0].upper() + i[1][1:-1] + " {\n")
            continue
        if table and not field and l == "==":  # Seperator after table description
            field = True
            continue
        if field and l == "}":
            table = False
            field = False
            file.write("    @Column\n")
            file.write("    private Date createdAt;\n")
            j = {
                "type": "Date",
                "name": "createdAt"
            }
            columns.append(j)
            file.write("    @Column\n")
            file.write("    private Date updatedAt;\n")
            j = {
                "type": "Date",
                "name": "updatedAt"
            }
            columns.append(j)
            get_set(columns, file)
            file.write("\n}")
            file.close()
            continue
        if field and l == "#id":
            file.write("    @Id\n")
            file.write("    private long id;\n")
            j = {
                "type": "long",
                "name": "id"
            }
            columns.append(j)
        if field and l != "#id":
            if field and idx:
                file.write("    @Name\n")
                file.write("    private " + dis_type(i[2]) + " " + fname + ";\n")
            else:
                file.write("    @Column\n")
                file.write("    private " + dis_type(i[2]) + " " + fname + ";\n")
            j = {
                "type": dis_type(i[2]),
                "name": fname
            }
            columns.append(j)


def dis_type(columnDes):
    if "varchar" in columnDes:
        return "String"
    if "decimal" in columnDes:
        return "double"
    if "bigint" in columnDes:
        return "long"
    if "int" in columnDes:
        return "int"
    if "boolean" in columnDes:
        return "boolean"
    if "datetime" in columnDes:
        return "Date"
    if "date" in columnDes:
        return "Date"


def get_set(columns, file):
    for item in columns:
        t = item.get("type")
        c = item.get("name")
        file.write("\n    public " + t + " get" + c[0].upper() + c[1:] + "() {\n")
        file.write("        return " + c + ";\n")
        file.write("    }\n")
        file.write("\n    public void set" + c[0].upper() + c[1:] + "(" + t + " " + c + ") {\n")
        file.write("        this." + c + " = " + c + ";\n")
        file.write("    }\n")


if __name__ == "__main__":
    main()
