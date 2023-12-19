import csv
import sys

def csv_to_markdown_table(csv_file):
    try:
        with open(csv_file, mode='r', encoding='utf-8') as file:
            reader = csv.DictReader(file)
            fields = reader.fieldnames

            # Check if required columns are present in the CSV
            required_columns = ['id', 'severity', 'title', 'description']
            if not all(col in fields for col in required_columns):
                raise ValueError("CSV must have id, severity, title, and description columns.")

            with open('README.md', mode='w', encoding='utf-8') as mdfile:
                # Additional columns with default values
                additional_columns = ['Custom Runtime Rule', 'Status', 'Assigned To', 'Link to Issue']
                mdfile.write('| ' + ' | '.join(required_columns + additional_columns) + ' |\n')
                mdfile.write('|' + '|'.join(['---' for _ in required_columns + additional_columns]) + '|\n')

                # Write the rows
                for row in reader:
                    # Default values for the additional columns
                    default_values = ['TBD', 'In Progress', 'Unassigned', '']
                    mdfile.write('| ' + ' | '.join([row[col] for col in required_columns] + default_values) + ' |\n')

        print("Markdown table has been successfully written to readme.md")
    except FileNotFoundError:
        print(f"Error: File '{csv_file}' not found.")
    except ValueError as e:
        print(e)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <path_to_csv_file>")
    else:
        csv_filename = sys.argv[1]
        csv_to_markdown_table(csv_filename)
