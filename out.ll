; ModuleID = 'top'
source_filename = "top"

define i64 @main() {
entry-point:
  %0 = alloca i64
  %1 = alloca i64
  store i64 5, i64* %1
  %2 = load i64, i64* %1
  %3 = add i64 1, %2
  store i64 %3, i64* %0
  %4 = load i64, i64* %0
  %5 = alloca i64
  %6 = alloca i64
  store i64 5, i64* %6
  %7 = load i64, i64* %6
  %8 = add i64 1, %7
  store i64 %8, i64* %5
  %9 = load i64, i64* %5
  %10 = alloca i64
  %11 = alloca i64
  store i64 5, i64* %11
  %12 = load i64, i64* %11
  %13 = add i64 1, %12
  store i64 %13, i64* %10
  %14 = load i64, i64* %10
  %15 = alloca i64
  %16 = alloca i64
  store i64 5, i64* %16
  %17 = load i64, i64* %16
  %18 = add i64 1, %17
  store i64 %18, i64* %15
  %19 = load i64, i64* %15
  %20 = alloca i64
  %21 = alloca i64
  store i64 3, i64* %21
  %22 = load i64, i64* %21
  %23 = add i64 %22, 3
  store i64 %23, i64* %20
  %24 = load i64, i64* %20
  %25 = alloca i64
  %26 = alloca i64
  store i64 3, i64* %26
  %27 = load i64, i64* %26
  %28 = add i64 %27, 3
  store i64 %28, i64* %25
  %29 = load i64, i64* %25
  %30 = alloca i64
  %31 = alloca i64
  store i64 3, i64* %31
  %32 = load i64, i64* %31
  %33 = add i64 %32, 3
  store i64 %33, i64* %30
  %34 = load i64, i64* %30
  %35 = alloca i64
  %36 = alloca i64
  store i64 3, i64* %36
  %37 = load i64, i64* %36
  %38 = add i64 %37, 3
  store i64 %38, i64* %35
  %39 = load i64, i64* %35
  %40 = alloca i64
  %41 = alloca i64
  store i64 3, i64* %41
  %42 = load i64, i64* %41
  %43 = add i64 %42, 3
  store i64 %43, i64* %40
  %44 = load i64, i64* %40
  %45 = alloca i64
  %46 = alloca i64
  store i64 3, i64* %46
  %47 = load i64, i64* %46
  %48 = add i64 %47, 3
  store i64 %48, i64* %45
  %49 = load i64, i64* %45
  %50 = alloca i64
  %51 = alloca i64
  store i64 3, i64* %51
  %52 = load i64, i64* %51
  %53 = add i64 %52, 3
  store i64 %53, i64* %50
  %54 = load i64, i64* %50
  %55 = alloca i64
  %56 = alloca i64
  store i64 3, i64* %56
  %57 = load i64, i64* %56
  %58 = add i64 %57, 3
  store i64 %58, i64* %55
  %59 = load i64, i64* %55
  %60 = alloca i64
  %61 = alloca i64
  store i64 3, i64* %61
  %62 = load i64, i64* %61
  %63 = add i64 %62, 3
  store i64 %63, i64* %60
  %64 = load i64, i64* %60
  %65 = alloca i64
  %66 = alloca i64
  store i64 3, i64* %66
  %67 = load i64, i64* %66
  %68 = add i64 %67, 3
  store i64 %68, i64* %65
  %69 = load i64, i64* %65
  %70 = alloca i64
  %71 = alloca i64
  store i64 3, i64* %71
  %72 = load i64, i64* %71
  %73 = add i64 %72, 3
  store i64 %73, i64* %70
  %74 = load i64, i64* %70
  %75 = alloca i64
  %76 = alloca i64
  store i64 3, i64* %76
  %77 = load i64, i64* %76
  %78 = add i64 %77, 3
  store i64 %78, i64* %75
  %79 = load i64, i64* %75
  %80 = alloca i64
  %81 = alloca i64
  store i64 5, i64* %81
  %82 = load i64, i64* %81
  %83 = add i64 1, %82
  store i64 %83, i64* %80
  %84 = load i64, i64* %80
  %85 = alloca i64
  %86 = alloca i64
  store i64 5, i64* %86
  %87 = load i64, i64* %86
  %88 = add i64 1, %87
  store i64 %88, i64* %85
  %89 = load i64, i64* %85
  %90 = alloca i64
  %91 = alloca i64
  store i64 3, i64* %91
  %92 = load i64, i64* %91
  %93 = add i64 %92, 3
  store i64 %93, i64* %90
  %94 = load i64, i64* %90
  %95 = alloca i64
  %96 = alloca i64
  store i64 3, i64* %96
  %97 = load i64, i64* %96
  %98 = add i64 %97, 3
  store i64 %98, i64* %95
  %99 = load i64, i64* %95
  %100 = alloca i64
  %101 = alloca i64
  store i64 5, i64* %101
  %102 = load i64, i64* %101
  %103 = add i64 1, %102
  store i64 %103, i64* %100
  %104 = load i64, i64* %100
  %105 = alloca i64
  %106 = alloca i64
  store i64 5, i64* %106
  %107 = load i64, i64* %106
  %108 = add i64 1, %107
  store i64 %108, i64* %105
  %109 = load i64, i64* %105
  %110 = alloca i64
  %111 = alloca i64
  store i64 3, i64* %111
  %112 = load i64, i64* %111
  %113 = add i64 %112, 3
  store i64 %113, i64* %110
  %114 = load i64, i64* %110
  %115 = alloca i64
  %116 = alloca i64
  store i64 3, i64* %116
  %117 = load i64, i64* %116
  %118 = add i64 %117, 3
  store i64 %118, i64* %115
  %119 = load i64, i64* %115
  %120 = alloca i64
  store i64 5, i64* %120
  %121 = load i64, i64* %120
  %122 = alloca i64
  store i64 4, i64* %122
  %123 = load i64, i64* %122
  %124 = alloca i64
  store i64 3, i64* %124
  %125 = load i64, i64* %124
  %126 = alloca i64
  store i64 2, i64* %126
  %127 = load i64, i64* %126
}
