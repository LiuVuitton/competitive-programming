#!/bin/bash

# ==============================================
# Usage:
#   ./run_cf.sh <problem_path> [mode]
# Examples:
#   ./run_cf.sh 0231A_bit_plus_plus
#   ./run_cf.sh 0231A_bit_plus_plus test
#   ./run_cf.sh codeforces/0231A_bit_plus_plus
#   ./run_cf.sh codeforces/0231A_bit_plus_plus test
# ==============================================

set -e

CODEFORCES_DIR="codeforces"
BUILD_DIR="build"

problem_path="$1"
mode="${2:-run}"  # Default to 'run' if not specified

if [ -z "$problem_path" ]; then
  echo "Usage: $0 <problem_path> [run|test]"
  exit 1
fi

# Normalize path and extract problem name
if [[ "$problem_path" == $CODEFORCES_DIR/* ]]; then
  problem_dir="$problem_path"
  problem_name=$(basename "$problem_path")
else
  problem_dir="$CODEFORCES_DIR/$problem_path"
  problem_name="$problem_path"
fi

if [ ! -d "$problem_dir" ]; then
  echo "❌ Folder not found: $problem_dir"
  exit 1
fi

mkdir -p "$BUILD_DIR"

cpp_file=$(find "$problem_dir" -maxdepth 1 -name "*.cpp" | head -n 1)
if [ ! -f "$cpp_file" ]; then
  echo "❌ No .cpp file found in $problem_dir"
  exit 1
fi

exe_file="$BUILD_DIR/${problem_name}.out"

echo "🔧 Compiling $cpp_file..."
if ! g++ -std=c++17 -O2 -Wall "$cpp_file" -o "$exe_file"; then
  echo "❌ Compilation failed."
  exit 1
fi
echo "✅ Compilation successful."

if [ "$mode" = "run" ]; then
  echo "▶️ Running program..."
  echo "--------------------------------------"
  "$exe_file"   # direct execution (normal behavior)
  echo "--------------------------------------"

elif [ "$mode" = "test" ]; then
  echo "🧪 Running test cases..."
  echo "--------------------------------------"
  total=0
  passed=0

  for input_file in "$problem_dir"/input*.txt; do
    [ -e "$input_file" ] || continue
    total=$((total + 1))
    base_name=$(basename "$input_file" .txt)
    expected_file="$problem_dir/${base_name/input/output}.txt"
    temp_output="$BUILD_DIR/${problem_name}_${base_name}_tmp.txt"

    echo "Running test: $base_name"
    "$exe_file" < "$input_file" > "$temp_output"

    if [ -f "$expected_file" ]; then
      if diff -q "$temp_output" "$expected_file" > /dev/null; then
        echo "✅ Passed"
        passed=$((passed + 1))
      else
        echo "❌ Failed"
        echo "--- Expected ---"
        cat "$expected_file"
        echo "--- Got ---"
        cat "$temp_output"
      fi
    else
      echo "⚠️ No expected output for $base_name. Skipping comparison."
      echo "Program output:"
      cat "$temp_output"
    fi
    echo "--------------------------------------"
  done

  echo "🧹 Cleaning temporary files..."
  rm -f "$BUILD_DIR/${problem_name}_input*_tmp.txt"

  if [ $total -gt 0 ]; then
    echo "✅ Summary: $passed / $total tests passed."
  else
    echo "ℹ️ No input*.txt files found for $problem_name."
  fi

else
  echo "❌ Unknown mode: $mode"
  echo "Available modes: run | test"
  exit 1
fi
