; ModuleID = 'intrin/intrin_64.bc'
source_filename = "intrin.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque

@stdout = external dso_local local_unnamed_addr global %struct._IO_FILE*, align 8
@stdin = external dso_local local_unnamed_addr global %struct._IO_FILE*, align 8

; Function Attrs: alwaysinline nofree norecurse nounwind uwtable willreturn mustprogress
define dso_local void @emit_add_ptr(i64* nocapture nonnull align 8 dereferenceable(8) %ptr, i8 signext %diff) local_unnamed_addr #0 {
entry:
  %conv = sext i8 %diff to i64
  %0 = load i64, i64* %ptr, align 8, !tbaa !2
  %add = add i64 %0, %conv
  store i64 %add, i64* %ptr, align 8, !tbaa !2
  ret void
}

; Function Attrs: alwaysinline nofree norecurse nounwind uwtable willreturn mustprogress
define dso_local void @emit_add(i8* nocapture %mem, i64* nocapture nonnull readonly align 8 dereferenceable(8) %ptr, i8 signext %diff) local_unnamed_addr #0 {
entry:
  %0 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx = getelementptr inbounds i8, i8* %mem, i64 %0
  %1 = load i8, i8* %arrayidx, align 1, !tbaa !6
  %add = add i8 %1, %diff
  store i8 %add, i8* %arrayidx, align 1, !tbaa !6
  ret void
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: alwaysinline nofree nounwind uwtable mustprogress
define dso_local void @emit_putchar(i8* nocapture readonly %mem, i64* nocapture nonnull readonly align 8 dereferenceable(8) %ptr) local_unnamed_addr #2 {
entry:
  %0 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx = getelementptr inbounds i8, i8* %mem, i64 %0
  %1 = load i8, i8* %arrayidx, align 1, !tbaa !6
  %conv = zext i8 %1 to i32
  %2 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i = tail call i32 @putc(i32 %conv, %struct._IO_FILE* %2) #9
  ret void
}

; Function Attrs: alwaysinline nofree nounwind uwtable mustprogress
define dso_local void @emit_getchar(i8* nocapture %mem, i64* nocapture nonnull readonly align 8 dereferenceable(8) %ptr) local_unnamed_addr #2 {
entry:
  %0 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8, !tbaa !7
  %call.i = tail call i32 @getc(%struct._IO_FILE* %0) #9
  %conv = trunc i32 %call.i to i8
  %1 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx = getelementptr inbounds i8, i8* %mem, i64 %1
  store i8 %conv, i8* %arrayidx, align 1, !tbaa !6
  ret void
}

; Function Attrs: alwaysinline norecurse nounwind readonly uwtable willreturn mustprogress
define dso_local zeroext i8 @fetch_memory(i8* nocapture readonly %mem, i64* nocapture nonnull readonly align 8 dereferenceable(8) %ptr) local_unnamed_addr #3 {
entry:
  %0 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx = getelementptr inbounds i8, i8* %mem, i64 %0
  %1 = load i8, i8* %arrayidx, align 1, !tbaa !6
  ret i8 %1
}

; Function Attrs: nounwind uwtable
define dso_local void @lifted() local_unnamed_addr #4 {
entry:
  %ptr.i = alloca i64, align 8
  %memory = alloca [30000 x i8], align 16
  %0 = getelementptr inbounds [30000 x i8], [30000 x i8]* %memory, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 30000, i8* nonnull %0) #9
  call void @llvm.memset.p0i8.i64(i8* nonnull align 16 dereferenceable(30000) %0, i8 0, i64 30000, i1 false)
  %1 = bitcast i64* %ptr.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* %1)
  store i64 0, i64* %ptr.i, align 8
  %2 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i.i = getelementptr inbounds i8, i8* %0, i64 %2
  %3 = load i8, i8* %arrayidx.i.i, align 1, !tbaa !6
  %add.i.i = add i8 %3, 1
  store i8 %add.i.i, i8* %arrayidx.i.i, align 1, !tbaa !6
  %4 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i51.i = getelementptr inbounds i8, i8* %0, i64 %4
  %5 = load i8, i8* %arrayidx.i51.i, align 1, !tbaa !6
  %add.i52.i = add i8 %5, 1
  store i8 %add.i52.i, i8* %arrayidx.i51.i, align 1, !tbaa !6
  %6 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i61.i = getelementptr inbounds i8, i8* %0, i64 %6
  %7 = load i8, i8* %arrayidx.i61.i, align 1, !tbaa !6
  %add.i62.i = add i8 %7, 1
  store i8 %add.i62.i, i8* %arrayidx.i61.i, align 1, !tbaa !6
  %8 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i70.i = getelementptr inbounds i8, i8* %0, i64 %8
  %9 = load i8, i8* %arrayidx.i70.i, align 1, !tbaa !6
  %add.i71.i = add i8 %9, 1
  store i8 %add.i71.i, i8* %arrayidx.i70.i, align 1, !tbaa !6
  %10 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i91.i = getelementptr inbounds i8, i8* %0, i64 %10
  %11 = load i8, i8* %arrayidx.i91.i, align 1, !tbaa !6
  %add.i92.i = add i8 %11, 1
  store i8 %add.i92.i, i8* %arrayidx.i91.i, align 1, !tbaa !6
  %12 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i108.i = getelementptr inbounds i8, i8* %0, i64 %12
  %13 = load i8, i8* %arrayidx.i108.i, align 1, !tbaa !6
  %add.i109.i = add i8 %13, 1
  store i8 %add.i109.i, i8* %arrayidx.i108.i, align 1, !tbaa !6
  %14 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i119.i = getelementptr inbounds i8, i8* %0, i64 %14
  %15 = load i8, i8* %arrayidx.i119.i, align 1, !tbaa !6
  %add.i120.i = add i8 %15, 1
  store i8 %add.i120.i, i8* %arrayidx.i119.i, align 1, !tbaa !6
  %16 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i125.i = getelementptr inbounds i8, i8* %0, i64 %16
  %17 = load i8, i8* %arrayidx.i125.i, align 1, !tbaa !6
  %add.i126.i = add i8 %17, 1
  store i8 %add.i126.i, i8* %arrayidx.i125.i, align 1, !tbaa !6
  br label %18

18:                                               ; preds = %82, %entry
  %19 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i133.i = getelementptr inbounds i8, i8* %0, i64 %19
  %20 = load i8, i8* %arrayidx.i133.i, align 1, !tbaa !6
  %.not.i = icmp eq i8 %20, 0
  br i1 %.not.i, label %hooked_stub.exit, label %21

21:                                               ; preds = %18
  %22 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i139.i = add i64 %22, 1
  store i64 %add.i139.i, i64* %ptr.i, align 8, !tbaa !2
  %23 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i149.i = getelementptr inbounds i8, i8* %0, i64 %23
  %24 = load i8, i8* %arrayidx.i149.i, align 1, !tbaa !6
  %add.i150.i = add i8 %24, 1
  store i8 %add.i150.i, i8* %arrayidx.i149.i, align 1, !tbaa !6
  %25 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i154.i = getelementptr inbounds i8, i8* %0, i64 %25
  %26 = load i8, i8* %arrayidx.i154.i, align 1, !tbaa !6
  %add.i155.i = add i8 %26, 1
  store i8 %add.i155.i, i8* %arrayidx.i154.i, align 1, !tbaa !6
  %27 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i173.i = getelementptr inbounds i8, i8* %0, i64 %27
  %28 = load i8, i8* %arrayidx.i173.i, align 1, !tbaa !6
  %add.i174.i = add i8 %28, 1
  store i8 %add.i174.i, i8* %arrayidx.i173.i, align 1, !tbaa !6
  %29 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i185.i = getelementptr inbounds i8, i8* %0, i64 %29
  %30 = load i8, i8* %arrayidx.i185.i, align 1, !tbaa !6
  %add.i186.i = add i8 %30, 1
  store i8 %add.i186.i, i8* %arrayidx.i185.i, align 1, !tbaa !6
  br label %31

31:                                               ; preds = %34, %21
  %32 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i49.i = getelementptr inbounds i8, i8* %0, i64 %32
  %33 = load i8, i8* %arrayidx.i49.i, align 1, !tbaa !6
  %.not1.i = icmp eq i8 %33, 0
  br i1 %.not1.i, label %63, label %34

34:                                               ; preds = %31
  %35 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i48.i = add i64 %35, 1
  store i64 %add.i48.i, i64* %ptr.i, align 8, !tbaa !2
  %36 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i46.i = getelementptr inbounds i8, i8* %0, i64 %36
  %37 = load i8, i8* %arrayidx.i46.i, align 1, !tbaa !6
  %add.i47.i = add i8 %37, 1
  store i8 %add.i47.i, i8* %arrayidx.i46.i, align 1, !tbaa !6
  %38 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i44.i = getelementptr inbounds i8, i8* %0, i64 %38
  %39 = load i8, i8* %arrayidx.i44.i, align 1, !tbaa !6
  %add.i45.i = add i8 %39, 1
  store i8 %add.i45.i, i8* %arrayidx.i44.i, align 1, !tbaa !6
  %40 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i43.i = add i64 %40, 1
  store i64 %add.i43.i, i64* %ptr.i, align 8, !tbaa !2
  %41 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i41.i = getelementptr inbounds i8, i8* %0, i64 %41
  %42 = load i8, i8* %arrayidx.i41.i, align 1, !tbaa !6
  %add.i42.i = add i8 %42, 1
  store i8 %add.i42.i, i8* %arrayidx.i41.i, align 1, !tbaa !6
  %43 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i39.i = getelementptr inbounds i8, i8* %0, i64 %43
  %44 = load i8, i8* %arrayidx.i39.i, align 1, !tbaa !6
  %add.i40.i = add i8 %44, 1
  store i8 %add.i40.i, i8* %arrayidx.i39.i, align 1, !tbaa !6
  %45 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i37.i = getelementptr inbounds i8, i8* %0, i64 %45
  %46 = load i8, i8* %arrayidx.i37.i, align 1, !tbaa !6
  %add.i38.i = add i8 %46, 1
  store i8 %add.i38.i, i8* %arrayidx.i37.i, align 1, !tbaa !6
  %47 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i36.i = add i64 %47, 1
  store i64 %add.i36.i, i64* %ptr.i, align 8, !tbaa !2
  %48 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i34.i = getelementptr inbounds i8, i8* %0, i64 %48
  %49 = load i8, i8* %arrayidx.i34.i, align 1, !tbaa !6
  %add.i35.i = add i8 %49, 1
  store i8 %add.i35.i, i8* %arrayidx.i34.i, align 1, !tbaa !6
  %50 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i32.i = getelementptr inbounds i8, i8* %0, i64 %50
  %51 = load i8, i8* %arrayidx.i32.i, align 1, !tbaa !6
  %add.i33.i = add i8 %51, 1
  store i8 %add.i33.i, i8* %arrayidx.i32.i, align 1, !tbaa !6
  %52 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i30.i = getelementptr inbounds i8, i8* %0, i64 %52
  %53 = load i8, i8* %arrayidx.i30.i, align 1, !tbaa !6
  %add.i31.i = add i8 %53, 1
  store i8 %add.i31.i, i8* %arrayidx.i30.i, align 1, !tbaa !6
  %54 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i29.i = add i64 %54, 1
  store i64 %add.i29.i, i64* %ptr.i, align 8, !tbaa !2
  %55 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i27.i = getelementptr inbounds i8, i8* %0, i64 %55
  %56 = load i8, i8* %arrayidx.i27.i, align 1, !tbaa !6
  %add.i28.i = add i8 %56, 1
  store i8 %add.i28.i, i8* %arrayidx.i27.i, align 1, !tbaa !6
  %57 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i26.i = add i64 %57, -1
  store i64 %add.i26.i, i64* %ptr.i, align 8, !tbaa !2
  %58 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i25.i = add i64 %58, -1
  store i64 %add.i25.i, i64* %ptr.i, align 8, !tbaa !2
  %59 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i24.i = add i64 %59, -1
  store i64 %add.i24.i, i64* %ptr.i, align 8, !tbaa !2
  %60 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i23.i = add i64 %60, -1
  store i64 %add.i23.i, i64* %ptr.i, align 8, !tbaa !2
  %61 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i21.i = getelementptr inbounds i8, i8* %0, i64 %61
  %62 = load i8, i8* %arrayidx.i21.i, align 1, !tbaa !6
  %add.i22.i = add i8 %62, -1
  store i8 %add.i22.i, i8* %arrayidx.i21.i, align 1, !tbaa !6
  br label %31

63:                                               ; preds = %31
  %64 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i20.i = add i64 %64, 1
  store i64 %add.i20.i, i64* %ptr.i, align 8, !tbaa !2
  %65 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i18.i = getelementptr inbounds i8, i8* %0, i64 %65
  %66 = load i8, i8* %arrayidx.i18.i, align 1, !tbaa !6
  %add.i19.i = add i8 %66, 1
  store i8 %add.i19.i, i8* %arrayidx.i18.i, align 1, !tbaa !6
  %67 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i17.i = add i64 %67, 1
  store i64 %add.i17.i, i64* %ptr.i, align 8, !tbaa !2
  %68 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i15.i = getelementptr inbounds i8, i8* %0, i64 %68
  %69 = load i8, i8* %arrayidx.i15.i, align 1, !tbaa !6
  %add.i16.i = add i8 %69, 1
  store i8 %add.i16.i, i8* %arrayidx.i15.i, align 1, !tbaa !6
  %70 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i14.i = add i64 %70, 1
  store i64 %add.i14.i, i64* %ptr.i, align 8, !tbaa !2
  %71 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i12.i = getelementptr inbounds i8, i8* %0, i64 %71
  %72 = load i8, i8* %arrayidx.i12.i, align 1, !tbaa !6
  %add.i13.i = add i8 %72, -1
  store i8 %add.i13.i, i8* %arrayidx.i12.i, align 1, !tbaa !6
  %73 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i11.i = add i64 %73, 1
  store i64 %add.i11.i, i64* %ptr.i, align 8, !tbaa !2
  %74 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i10.i = add i64 %74, 1
  store i64 %add.i10.i, i64* %ptr.i, align 8, !tbaa !2
  %75 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i8.i = getelementptr inbounds i8, i8* %0, i64 %75
  %76 = load i8, i8* %arrayidx.i8.i, align 1, !tbaa !6
  %add.i9.i = add i8 %76, 1
  store i8 %add.i9.i, i8* %arrayidx.i8.i, align 1, !tbaa !6
  br label %77

77:                                               ; preds = %80, %63
  %78 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i7.i = getelementptr inbounds i8, i8* %0, i64 %78
  %79 = load i8, i8* %arrayidx.i7.i, align 1, !tbaa !6
  %.not2.i = icmp eq i8 %79, 0
  br i1 %.not2.i, label %82, label %80

80:                                               ; preds = %77
  %81 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i6.i = add i64 %81, -1
  store i64 %add.i6.i, i64* %ptr.i, align 8, !tbaa !2
  br label %77

82:                                               ; preds = %77
  %83 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i5.i = add i64 %83, -1
  store i64 %add.i5.i, i64* %ptr.i, align 8, !tbaa !2
  %84 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i3.i = getelementptr inbounds i8, i8* %0, i64 %84
  %85 = load i8, i8* %arrayidx.i3.i, align 1, !tbaa !6
  %add.i4.i = add i8 %85, -1
  store i8 %add.i4.i, i8* %arrayidx.i3.i, align 1, !tbaa !6
  br label %18

hooked_stub.exit:                                 ; preds = %18
  %86 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i188.i = add i64 %86, 1
  store i64 %add.i188.i, i64* %ptr.i, align 8, !tbaa !2
  %87 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i187.i = add i64 %87, 1
  store i64 %add.i187.i, i64* %ptr.i, align 8, !tbaa !2
  %88 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i182.i = getelementptr inbounds i8, i8* %0, i64 %88
  %89 = load i8, i8* %arrayidx.i182.i, align 1, !tbaa !6
  %conv.i183.i = zext i8 %89 to i32
  %90 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i184.i = call i32 @putc(i32 %conv.i183.i, %struct._IO_FILE* %90) #9
  %91 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i181.i = add i64 %91, 1
  store i64 %add.i181.i, i64* %ptr.i, align 8, !tbaa !2
  %92 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i179.i = getelementptr inbounds i8, i8* %0, i64 %92
  %93 = load i8, i8* %arrayidx.i179.i, align 1, !tbaa !6
  %add.i180.i = add i8 %93, -1
  store i8 %add.i180.i, i8* %arrayidx.i179.i, align 1, !tbaa !6
  %94 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i177.i = getelementptr inbounds i8, i8* %0, i64 %94
  %95 = load i8, i8* %arrayidx.i177.i, align 1, !tbaa !6
  %add.i178.i = add i8 %95, -1
  store i8 %add.i178.i, i8* %arrayidx.i177.i, align 1, !tbaa !6
  %96 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i175.i = getelementptr inbounds i8, i8* %0, i64 %96
  %97 = load i8, i8* %arrayidx.i175.i, align 1, !tbaa !6
  %add.i176.i = add i8 %97, -1
  store i8 %add.i176.i, i8* %arrayidx.i175.i, align 1, !tbaa !6
  %98 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i170.i = getelementptr inbounds i8, i8* %0, i64 %98
  %99 = load i8, i8* %arrayidx.i170.i, align 1, !tbaa !6
  %conv.i171.i = zext i8 %99 to i32
  %100 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i172.i = call i32 @putc(i32 %conv.i171.i, %struct._IO_FILE* %100) #9
  %101 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i168.i = getelementptr inbounds i8, i8* %0, i64 %101
  %102 = load i8, i8* %arrayidx.i168.i, align 1, !tbaa !6
  %add.i169.i = add i8 %102, 1
  store i8 %add.i169.i, i8* %arrayidx.i168.i, align 1, !tbaa !6
  %103 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i166.i = getelementptr inbounds i8, i8* %0, i64 %103
  %104 = load i8, i8* %arrayidx.i166.i, align 1, !tbaa !6
  %add.i167.i = add i8 %104, 1
  store i8 %add.i167.i, i8* %arrayidx.i166.i, align 1, !tbaa !6
  %105 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i164.i = getelementptr inbounds i8, i8* %0, i64 %105
  %106 = load i8, i8* %arrayidx.i164.i, align 1, !tbaa !6
  %add.i165.i = add i8 %106, 1
  store i8 %add.i165.i, i8* %arrayidx.i164.i, align 1, !tbaa !6
  %107 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i162.i = getelementptr inbounds i8, i8* %0, i64 %107
  %108 = load i8, i8* %arrayidx.i162.i, align 1, !tbaa !6
  %add.i163.i = add i8 %108, 1
  store i8 %add.i163.i, i8* %arrayidx.i162.i, align 1, !tbaa !6
  %109 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i160.i = getelementptr inbounds i8, i8* %0, i64 %109
  %110 = load i8, i8* %arrayidx.i160.i, align 1, !tbaa !6
  %add.i161.i = add i8 %110, 1
  store i8 %add.i161.i, i8* %arrayidx.i160.i, align 1, !tbaa !6
  %111 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i158.i = getelementptr inbounds i8, i8* %0, i64 %111
  %112 = load i8, i8* %arrayidx.i158.i, align 1, !tbaa !6
  %add.i159.i = add i8 %112, 1
  store i8 %add.i159.i, i8* %arrayidx.i158.i, align 1, !tbaa !6
  %113 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i156.i = getelementptr inbounds i8, i8* %0, i64 %113
  %114 = load i8, i8* %arrayidx.i156.i, align 1, !tbaa !6
  %add.i157.i = add i8 %114, 1
  store i8 %add.i157.i, i8* %arrayidx.i156.i, align 1, !tbaa !6
  %115 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i151.i = getelementptr inbounds i8, i8* %0, i64 %115
  %116 = load i8, i8* %arrayidx.i151.i, align 1, !tbaa !6
  %conv.i152.i = zext i8 %116 to i32
  %117 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i153.i = call i32 @putc(i32 %conv.i152.i, %struct._IO_FILE* %117) #9
  %118 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i146.i = getelementptr inbounds i8, i8* %0, i64 %118
  %119 = load i8, i8* %arrayidx.i146.i, align 1, !tbaa !6
  %conv.i147.i = zext i8 %119 to i32
  %120 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i148.i = call i32 @putc(i32 %conv.i147.i, %struct._IO_FILE* %120) #9
  %121 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i144.i = getelementptr inbounds i8, i8* %0, i64 %121
  %122 = load i8, i8* %arrayidx.i144.i, align 1, !tbaa !6
  %add.i145.i = add i8 %122, 1
  store i8 %add.i145.i, i8* %arrayidx.i144.i, align 1, !tbaa !6
  %123 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i142.i = getelementptr inbounds i8, i8* %0, i64 %123
  %124 = load i8, i8* %arrayidx.i142.i, align 1, !tbaa !6
  %add.i143.i = add i8 %124, 1
  store i8 %add.i143.i, i8* %arrayidx.i142.i, align 1, !tbaa !6
  %125 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i140.i = getelementptr inbounds i8, i8* %0, i64 %125
  %126 = load i8, i8* %arrayidx.i140.i, align 1, !tbaa !6
  %add.i141.i = add i8 %126, 1
  store i8 %add.i141.i, i8* %arrayidx.i140.i, align 1, !tbaa !6
  %127 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i136.i = getelementptr inbounds i8, i8* %0, i64 %127
  %128 = load i8, i8* %arrayidx.i136.i, align 1, !tbaa !6
  %conv.i137.i = zext i8 %128 to i32
  %129 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i138.i = call i32 @putc(i32 %conv.i137.i, %struct._IO_FILE* %129) #9
  %130 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i135.i = add i64 %130, 1
  store i64 %add.i135.i, i64* %ptr.i, align 8, !tbaa !2
  %131 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i134.i = add i64 %131, 1
  store i64 %add.i134.i, i64* %ptr.i, align 8, !tbaa !2
  %132 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i130.i = getelementptr inbounds i8, i8* %0, i64 %132
  %133 = load i8, i8* %arrayidx.i130.i, align 1, !tbaa !6
  %conv.i131.i = zext i8 %133 to i32
  %134 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i132.i = call i32 @putc(i32 %conv.i131.i, %struct._IO_FILE* %134) #9
  %135 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i129.i = add i64 %135, -1
  store i64 %add.i129.i, i64* %ptr.i, align 8, !tbaa !2
  %136 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i127.i = getelementptr inbounds i8, i8* %0, i64 %136
  %137 = load i8, i8* %arrayidx.i127.i, align 1, !tbaa !6
  %add.i128.i = add i8 %137, -1
  store i8 %add.i128.i, i8* %arrayidx.i127.i, align 1, !tbaa !6
  %138 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i122.i = getelementptr inbounds i8, i8* %0, i64 %138
  %139 = load i8, i8* %arrayidx.i122.i, align 1, !tbaa !6
  %conv.i123.i = zext i8 %139 to i32
  %140 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i124.i = call i32 @putc(i32 %conv.i123.i, %struct._IO_FILE* %140) #9
  %141 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i121.i = add i64 %141, -1
  store i64 %add.i121.i, i64* %ptr.i, align 8, !tbaa !2
  %142 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i116.i = getelementptr inbounds i8, i8* %0, i64 %142
  %143 = load i8, i8* %arrayidx.i116.i, align 1, !tbaa !6
  %conv.i117.i = zext i8 %143 to i32
  %144 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i118.i = call i32 @putc(i32 %conv.i117.i, %struct._IO_FILE* %144) #9
  %145 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i114.i = getelementptr inbounds i8, i8* %0, i64 %145
  %146 = load i8, i8* %arrayidx.i114.i, align 1, !tbaa !6
  %add.i115.i = add i8 %146, 1
  store i8 %add.i115.i, i8* %arrayidx.i114.i, align 1, !tbaa !6
  %147 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i112.i = getelementptr inbounds i8, i8* %0, i64 %147
  %148 = load i8, i8* %arrayidx.i112.i, align 1, !tbaa !6
  %add.i113.i = add i8 %148, 1
  store i8 %add.i113.i, i8* %arrayidx.i112.i, align 1, !tbaa !6
  %149 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i110.i = getelementptr inbounds i8, i8* %0, i64 %149
  %150 = load i8, i8* %arrayidx.i110.i, align 1, !tbaa !6
  %add.i111.i = add i8 %150, 1
  store i8 %add.i111.i, i8* %arrayidx.i110.i, align 1, !tbaa !6
  %151 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i105.i = getelementptr inbounds i8, i8* %0, i64 %151
  %152 = load i8, i8* %arrayidx.i105.i, align 1, !tbaa !6
  %conv.i106.i = zext i8 %152 to i32
  %153 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i107.i = call i32 @putc(i32 %conv.i106.i, %struct._IO_FILE* %153) #9
  %154 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i103.i = getelementptr inbounds i8, i8* %0, i64 %154
  %155 = load i8, i8* %arrayidx.i103.i, align 1, !tbaa !6
  %add.i104.i = add i8 %155, -1
  store i8 %add.i104.i, i8* %arrayidx.i103.i, align 1, !tbaa !6
  %156 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i101.i = getelementptr inbounds i8, i8* %0, i64 %156
  %157 = load i8, i8* %arrayidx.i101.i, align 1, !tbaa !6
  %add.i102.i = add i8 %157, -1
  store i8 %add.i102.i, i8* %arrayidx.i101.i, align 1, !tbaa !6
  %158 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i99.i = getelementptr inbounds i8, i8* %0, i64 %158
  %159 = load i8, i8* %arrayidx.i99.i, align 1, !tbaa !6
  %add.i100.i = add i8 %159, -1
  store i8 %add.i100.i, i8* %arrayidx.i99.i, align 1, !tbaa !6
  %160 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i97.i = getelementptr inbounds i8, i8* %0, i64 %160
  %161 = load i8, i8* %arrayidx.i97.i, align 1, !tbaa !6
  %add.i98.i = add i8 %161, -1
  store i8 %add.i98.i, i8* %arrayidx.i97.i, align 1, !tbaa !6
  %162 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i95.i = getelementptr inbounds i8, i8* %0, i64 %162
  %163 = load i8, i8* %arrayidx.i95.i, align 1, !tbaa !6
  %add.i96.i = add i8 %163, -1
  store i8 %add.i96.i, i8* %arrayidx.i95.i, align 1, !tbaa !6
  %164 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i93.i = getelementptr inbounds i8, i8* %0, i64 %164
  %165 = load i8, i8* %arrayidx.i93.i, align 1, !tbaa !6
  %add.i94.i = add i8 %165, -1
  store i8 %add.i94.i, i8* %arrayidx.i93.i, align 1, !tbaa !6
  %166 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i88.i = getelementptr inbounds i8, i8* %0, i64 %166
  %167 = load i8, i8* %arrayidx.i88.i, align 1, !tbaa !6
  %conv.i89.i = zext i8 %167 to i32
  %168 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i90.i = call i32 @putc(i32 %conv.i89.i, %struct._IO_FILE* %168) #9
  %169 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i86.i = getelementptr inbounds i8, i8* %0, i64 %169
  %170 = load i8, i8* %arrayidx.i86.i, align 1, !tbaa !6
  %add.i87.i = add i8 %170, -1
  store i8 %add.i87.i, i8* %arrayidx.i86.i, align 1, !tbaa !6
  %171 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i84.i = getelementptr inbounds i8, i8* %0, i64 %171
  %172 = load i8, i8* %arrayidx.i84.i, align 1, !tbaa !6
  %add.i85.i = add i8 %172, -1
  store i8 %add.i85.i, i8* %arrayidx.i84.i, align 1, !tbaa !6
  %173 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i82.i = getelementptr inbounds i8, i8* %0, i64 %173
  %174 = load i8, i8* %arrayidx.i82.i, align 1, !tbaa !6
  %add.i83.i = add i8 %174, -1
  store i8 %add.i83.i, i8* %arrayidx.i82.i, align 1, !tbaa !6
  %175 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i80.i = getelementptr inbounds i8, i8* %0, i64 %175
  %176 = load i8, i8* %arrayidx.i80.i, align 1, !tbaa !6
  %add.i81.i = add i8 %176, -1
  store i8 %add.i81.i, i8* %arrayidx.i80.i, align 1, !tbaa !6
  %177 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i78.i = getelementptr inbounds i8, i8* %0, i64 %177
  %178 = load i8, i8* %arrayidx.i78.i, align 1, !tbaa !6
  %add.i79.i = add i8 %178, -1
  store i8 %add.i79.i, i8* %arrayidx.i78.i, align 1, !tbaa !6
  %179 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i76.i = getelementptr inbounds i8, i8* %0, i64 %179
  %180 = load i8, i8* %arrayidx.i76.i, align 1, !tbaa !6
  %add.i77.i = add i8 %180, -1
  store i8 %add.i77.i, i8* %arrayidx.i76.i, align 1, !tbaa !6
  %181 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i74.i = getelementptr inbounds i8, i8* %0, i64 %181
  %182 = load i8, i8* %arrayidx.i74.i, align 1, !tbaa !6
  %add.i75.i = add i8 %182, -1
  store i8 %add.i75.i, i8* %arrayidx.i74.i, align 1, !tbaa !6
  %183 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i72.i = getelementptr inbounds i8, i8* %0, i64 %183
  %184 = load i8, i8* %arrayidx.i72.i, align 1, !tbaa !6
  %add.i73.i = add i8 %184, -1
  store i8 %add.i73.i, i8* %arrayidx.i72.i, align 1, !tbaa !6
  %185 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i67.i = getelementptr inbounds i8, i8* %0, i64 %185
  %186 = load i8, i8* %arrayidx.i67.i, align 1, !tbaa !6
  %conv.i68.i = zext i8 %186 to i32
  %187 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i69.i = call i32 @putc(i32 %conv.i68.i, %struct._IO_FILE* %187) #9
  %188 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i66.i = add i64 %188, 1
  store i64 %add.i66.i, i64* %ptr.i, align 8, !tbaa !2
  %189 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i65.i = add i64 %189, 1
  store i64 %add.i65.i, i64* %ptr.i, align 8, !tbaa !2
  %190 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i63.i = getelementptr inbounds i8, i8* %0, i64 %190
  %191 = load i8, i8* %arrayidx.i63.i, align 1, !tbaa !6
  %add.i64.i = add i8 %191, 1
  store i8 %add.i64.i, i8* %arrayidx.i63.i, align 1, !tbaa !6
  %192 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i58.i = getelementptr inbounds i8, i8* %0, i64 %192
  %193 = load i8, i8* %arrayidx.i58.i, align 1, !tbaa !6
  %conv.i59.i = zext i8 %193 to i32
  %194 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i60.i = call i32 @putc(i32 %conv.i59.i, %struct._IO_FILE* %194) #9
  %195 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i57.i = add i64 %195, 1
  store i64 %add.i57.i, i64* %ptr.i, align 8, !tbaa !2
  %196 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i55.i = getelementptr inbounds i8, i8* %0, i64 %196
  %197 = load i8, i8* %arrayidx.i55.i, align 1, !tbaa !6
  %add.i56.i = add i8 %197, 1
  store i8 %add.i56.i, i8* %arrayidx.i55.i, align 1, !tbaa !6
  %198 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i53.i = getelementptr inbounds i8, i8* %0, i64 %198
  %199 = load i8, i8* %arrayidx.i53.i, align 1, !tbaa !6
  %add.i54.i = add i8 %199, 1
  store i8 %add.i54.i, i8* %arrayidx.i53.i, align 1, !tbaa !6
  %200 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i50.i = getelementptr inbounds i8, i8* %0, i64 %200
  %201 = load i8, i8* %arrayidx.i50.i, align 1, !tbaa !6
  %conv.i.i = zext i8 %201 to i32
  %202 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i.i = call i32 @putc(i32 %conv.i.i, %struct._IO_FILE* %202) #9
  %203 = bitcast i64* %ptr.i to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %203)
  call void @llvm.lifetime.end.p0i8(i64 30000, i8* nonnull %0) #9
  ret void
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #5

declare dso_local void @stub(i8*) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @putc(i32 noundef, %struct._IO_FILE* nocapture noundef) local_unnamed_addr #7

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @getc(%struct._IO_FILE* nocapture noundef) local_unnamed_addr #7

; Function Attrs: alwaysinline
define void @hooked_stub(i8* %0) #8 {
  %ptr = alloca i64, align 8
  store i64 0, i64* %ptr, align 8
  %2 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i = getelementptr inbounds i8, i8* %0, i64 %2
  %3 = load i8, i8* %arrayidx.i, align 1, !tbaa !6
  %add.i = add i8 %3, 1
  store i8 %add.i, i8* %arrayidx.i, align 1, !tbaa !6
  %4 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i51 = getelementptr inbounds i8, i8* %0, i64 %4
  %5 = load i8, i8* %arrayidx.i51, align 1, !tbaa !6
  %add.i52 = add i8 %5, 1
  store i8 %add.i52, i8* %arrayidx.i51, align 1, !tbaa !6
  %6 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i61 = getelementptr inbounds i8, i8* %0, i64 %6
  %7 = load i8, i8* %arrayidx.i61, align 1, !tbaa !6
  %add.i62 = add i8 %7, 1
  store i8 %add.i62, i8* %arrayidx.i61, align 1, !tbaa !6
  %8 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i70 = getelementptr inbounds i8, i8* %0, i64 %8
  %9 = load i8, i8* %arrayidx.i70, align 1, !tbaa !6
  %add.i71 = add i8 %9, 1
  store i8 %add.i71, i8* %arrayidx.i70, align 1, !tbaa !6
  %10 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i91 = getelementptr inbounds i8, i8* %0, i64 %10
  %11 = load i8, i8* %arrayidx.i91, align 1, !tbaa !6
  %add.i92 = add i8 %11, 1
  store i8 %add.i92, i8* %arrayidx.i91, align 1, !tbaa !6
  %12 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i108 = getelementptr inbounds i8, i8* %0, i64 %12
  %13 = load i8, i8* %arrayidx.i108, align 1, !tbaa !6
  %add.i109 = add i8 %13, 1
  store i8 %add.i109, i8* %arrayidx.i108, align 1, !tbaa !6
  %14 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i119 = getelementptr inbounds i8, i8* %0, i64 %14
  %15 = load i8, i8* %arrayidx.i119, align 1, !tbaa !6
  %add.i120 = add i8 %15, 1
  store i8 %add.i120, i8* %arrayidx.i119, align 1, !tbaa !6
  %16 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i125 = getelementptr inbounds i8, i8* %0, i64 %16
  %17 = load i8, i8* %arrayidx.i125, align 1, !tbaa !6
  %add.i126 = add i8 %17, 1
  store i8 %add.i126, i8* %arrayidx.i125, align 1, !tbaa !6
  br label %18

18:                                               ; preds = %200, %1
  %19 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i133 = getelementptr inbounds i8, i8* %0, i64 %19
  %20 = load i8, i8* %arrayidx.i133, align 1, !tbaa !6
  %.not = icmp eq i8 %20, 0
  br i1 %.not, label %31, label %21

21:                                               ; preds = %18
  %22 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i139 = add i64 %22, 1
  store i64 %add.i139, i64* %ptr, align 8, !tbaa !2
  %23 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i149 = getelementptr inbounds i8, i8* %0, i64 %23
  %24 = load i8, i8* %arrayidx.i149, align 1, !tbaa !6
  %add.i150 = add i8 %24, 1
  store i8 %add.i150, i8* %arrayidx.i149, align 1, !tbaa !6
  %25 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i154 = getelementptr inbounds i8, i8* %0, i64 %25
  %26 = load i8, i8* %arrayidx.i154, align 1, !tbaa !6
  %add.i155 = add i8 %26, 1
  store i8 %add.i155, i8* %arrayidx.i154, align 1, !tbaa !6
  %27 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i173 = getelementptr inbounds i8, i8* %0, i64 %27
  %28 = load i8, i8* %arrayidx.i173, align 1, !tbaa !6
  %add.i174 = add i8 %28, 1
  store i8 %add.i174, i8* %arrayidx.i173, align 1, !tbaa !6
  %29 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i185 = getelementptr inbounds i8, i8* %0, i64 %29
  %30 = load i8, i8* %arrayidx.i185, align 1, !tbaa !6
  %add.i186 = add i8 %30, 1
  store i8 %add.i186, i8* %arrayidx.i185, align 1, !tbaa !6
  br label %149

31:                                               ; preds = %18
  %32 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i188 = add i64 %32, 1
  store i64 %add.i188, i64* %ptr, align 8, !tbaa !2
  %33 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i187 = add i64 %33, 1
  store i64 %add.i187, i64* %ptr, align 8, !tbaa !2
  %34 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i182 = getelementptr inbounds i8, i8* %0, i64 %34
  %35 = load i8, i8* %arrayidx.i182, align 1, !tbaa !6
  %conv.i183 = zext i8 %35 to i32
  %36 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i184 = call i32 @putc(i32 %conv.i183, %struct._IO_FILE* %36) #9
  %37 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i181 = add i64 %37, 1
  store i64 %add.i181, i64* %ptr, align 8, !tbaa !2
  %38 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i179 = getelementptr inbounds i8, i8* %0, i64 %38
  %39 = load i8, i8* %arrayidx.i179, align 1, !tbaa !6
  %add.i180 = add i8 %39, -1
  store i8 %add.i180, i8* %arrayidx.i179, align 1, !tbaa !6
  %40 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i177 = getelementptr inbounds i8, i8* %0, i64 %40
  %41 = load i8, i8* %arrayidx.i177, align 1, !tbaa !6
  %add.i178 = add i8 %41, -1
  store i8 %add.i178, i8* %arrayidx.i177, align 1, !tbaa !6
  %42 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i175 = getelementptr inbounds i8, i8* %0, i64 %42
  %43 = load i8, i8* %arrayidx.i175, align 1, !tbaa !6
  %add.i176 = add i8 %43, -1
  store i8 %add.i176, i8* %arrayidx.i175, align 1, !tbaa !6
  %44 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i170 = getelementptr inbounds i8, i8* %0, i64 %44
  %45 = load i8, i8* %arrayidx.i170, align 1, !tbaa !6
  %conv.i171 = zext i8 %45 to i32
  %46 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i172 = call i32 @putc(i32 %conv.i171, %struct._IO_FILE* %46) #9
  %47 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i168 = getelementptr inbounds i8, i8* %0, i64 %47
  %48 = load i8, i8* %arrayidx.i168, align 1, !tbaa !6
  %add.i169 = add i8 %48, 1
  store i8 %add.i169, i8* %arrayidx.i168, align 1, !tbaa !6
  %49 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i166 = getelementptr inbounds i8, i8* %0, i64 %49
  %50 = load i8, i8* %arrayidx.i166, align 1, !tbaa !6
  %add.i167 = add i8 %50, 1
  store i8 %add.i167, i8* %arrayidx.i166, align 1, !tbaa !6
  %51 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i164 = getelementptr inbounds i8, i8* %0, i64 %51
  %52 = load i8, i8* %arrayidx.i164, align 1, !tbaa !6
  %add.i165 = add i8 %52, 1
  store i8 %add.i165, i8* %arrayidx.i164, align 1, !tbaa !6
  %53 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i162 = getelementptr inbounds i8, i8* %0, i64 %53
  %54 = load i8, i8* %arrayidx.i162, align 1, !tbaa !6
  %add.i163 = add i8 %54, 1
  store i8 %add.i163, i8* %arrayidx.i162, align 1, !tbaa !6
  %55 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i160 = getelementptr inbounds i8, i8* %0, i64 %55
  %56 = load i8, i8* %arrayidx.i160, align 1, !tbaa !6
  %add.i161 = add i8 %56, 1
  store i8 %add.i161, i8* %arrayidx.i160, align 1, !tbaa !6
  %57 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i158 = getelementptr inbounds i8, i8* %0, i64 %57
  %58 = load i8, i8* %arrayidx.i158, align 1, !tbaa !6
  %add.i159 = add i8 %58, 1
  store i8 %add.i159, i8* %arrayidx.i158, align 1, !tbaa !6
  %59 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i156 = getelementptr inbounds i8, i8* %0, i64 %59
  %60 = load i8, i8* %arrayidx.i156, align 1, !tbaa !6
  %add.i157 = add i8 %60, 1
  store i8 %add.i157, i8* %arrayidx.i156, align 1, !tbaa !6
  %61 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i151 = getelementptr inbounds i8, i8* %0, i64 %61
  %62 = load i8, i8* %arrayidx.i151, align 1, !tbaa !6
  %conv.i152 = zext i8 %62 to i32
  %63 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i153 = call i32 @putc(i32 %conv.i152, %struct._IO_FILE* %63) #9
  %64 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i146 = getelementptr inbounds i8, i8* %0, i64 %64
  %65 = load i8, i8* %arrayidx.i146, align 1, !tbaa !6
  %conv.i147 = zext i8 %65 to i32
  %66 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i148 = call i32 @putc(i32 %conv.i147, %struct._IO_FILE* %66) #9
  %67 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i144 = getelementptr inbounds i8, i8* %0, i64 %67
  %68 = load i8, i8* %arrayidx.i144, align 1, !tbaa !6
  %add.i145 = add i8 %68, 1
  store i8 %add.i145, i8* %arrayidx.i144, align 1, !tbaa !6
  %69 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i142 = getelementptr inbounds i8, i8* %0, i64 %69
  %70 = load i8, i8* %arrayidx.i142, align 1, !tbaa !6
  %add.i143 = add i8 %70, 1
  store i8 %add.i143, i8* %arrayidx.i142, align 1, !tbaa !6
  %71 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i140 = getelementptr inbounds i8, i8* %0, i64 %71
  %72 = load i8, i8* %arrayidx.i140, align 1, !tbaa !6
  %add.i141 = add i8 %72, 1
  store i8 %add.i141, i8* %arrayidx.i140, align 1, !tbaa !6
  %73 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i136 = getelementptr inbounds i8, i8* %0, i64 %73
  %74 = load i8, i8* %arrayidx.i136, align 1, !tbaa !6
  %conv.i137 = zext i8 %74 to i32
  %75 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i138 = call i32 @putc(i32 %conv.i137, %struct._IO_FILE* %75) #9
  %76 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i135 = add i64 %76, 1
  store i64 %add.i135, i64* %ptr, align 8, !tbaa !2
  %77 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i134 = add i64 %77, 1
  store i64 %add.i134, i64* %ptr, align 8, !tbaa !2
  %78 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i130 = getelementptr inbounds i8, i8* %0, i64 %78
  %79 = load i8, i8* %arrayidx.i130, align 1, !tbaa !6
  %conv.i131 = zext i8 %79 to i32
  %80 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i132 = call i32 @putc(i32 %conv.i131, %struct._IO_FILE* %80) #9
  %81 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i129 = add i64 %81, -1
  store i64 %add.i129, i64* %ptr, align 8, !tbaa !2
  %82 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i127 = getelementptr inbounds i8, i8* %0, i64 %82
  %83 = load i8, i8* %arrayidx.i127, align 1, !tbaa !6
  %add.i128 = add i8 %83, -1
  store i8 %add.i128, i8* %arrayidx.i127, align 1, !tbaa !6
  %84 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i122 = getelementptr inbounds i8, i8* %0, i64 %84
  %85 = load i8, i8* %arrayidx.i122, align 1, !tbaa !6
  %conv.i123 = zext i8 %85 to i32
  %86 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i124 = call i32 @putc(i32 %conv.i123, %struct._IO_FILE* %86) #9
  %87 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i121 = add i64 %87, -1
  store i64 %add.i121, i64* %ptr, align 8, !tbaa !2
  %88 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i116 = getelementptr inbounds i8, i8* %0, i64 %88
  %89 = load i8, i8* %arrayidx.i116, align 1, !tbaa !6
  %conv.i117 = zext i8 %89 to i32
  %90 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i118 = call i32 @putc(i32 %conv.i117, %struct._IO_FILE* %90) #9
  %91 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i114 = getelementptr inbounds i8, i8* %0, i64 %91
  %92 = load i8, i8* %arrayidx.i114, align 1, !tbaa !6
  %add.i115 = add i8 %92, 1
  store i8 %add.i115, i8* %arrayidx.i114, align 1, !tbaa !6
  %93 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i112 = getelementptr inbounds i8, i8* %0, i64 %93
  %94 = load i8, i8* %arrayidx.i112, align 1, !tbaa !6
  %add.i113 = add i8 %94, 1
  store i8 %add.i113, i8* %arrayidx.i112, align 1, !tbaa !6
  %95 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i110 = getelementptr inbounds i8, i8* %0, i64 %95
  %96 = load i8, i8* %arrayidx.i110, align 1, !tbaa !6
  %add.i111 = add i8 %96, 1
  store i8 %add.i111, i8* %arrayidx.i110, align 1, !tbaa !6
  %97 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i105 = getelementptr inbounds i8, i8* %0, i64 %97
  %98 = load i8, i8* %arrayidx.i105, align 1, !tbaa !6
  %conv.i106 = zext i8 %98 to i32
  %99 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i107 = call i32 @putc(i32 %conv.i106, %struct._IO_FILE* %99) #9
  %100 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i103 = getelementptr inbounds i8, i8* %0, i64 %100
  %101 = load i8, i8* %arrayidx.i103, align 1, !tbaa !6
  %add.i104 = add i8 %101, -1
  store i8 %add.i104, i8* %arrayidx.i103, align 1, !tbaa !6
  %102 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i101 = getelementptr inbounds i8, i8* %0, i64 %102
  %103 = load i8, i8* %arrayidx.i101, align 1, !tbaa !6
  %add.i102 = add i8 %103, -1
  store i8 %add.i102, i8* %arrayidx.i101, align 1, !tbaa !6
  %104 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i99 = getelementptr inbounds i8, i8* %0, i64 %104
  %105 = load i8, i8* %arrayidx.i99, align 1, !tbaa !6
  %add.i100 = add i8 %105, -1
  store i8 %add.i100, i8* %arrayidx.i99, align 1, !tbaa !6
  %106 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i97 = getelementptr inbounds i8, i8* %0, i64 %106
  %107 = load i8, i8* %arrayidx.i97, align 1, !tbaa !6
  %add.i98 = add i8 %107, -1
  store i8 %add.i98, i8* %arrayidx.i97, align 1, !tbaa !6
  %108 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i95 = getelementptr inbounds i8, i8* %0, i64 %108
  %109 = load i8, i8* %arrayidx.i95, align 1, !tbaa !6
  %add.i96 = add i8 %109, -1
  store i8 %add.i96, i8* %arrayidx.i95, align 1, !tbaa !6
  %110 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i93 = getelementptr inbounds i8, i8* %0, i64 %110
  %111 = load i8, i8* %arrayidx.i93, align 1, !tbaa !6
  %add.i94 = add i8 %111, -1
  store i8 %add.i94, i8* %arrayidx.i93, align 1, !tbaa !6
  %112 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i88 = getelementptr inbounds i8, i8* %0, i64 %112
  %113 = load i8, i8* %arrayidx.i88, align 1, !tbaa !6
  %conv.i89 = zext i8 %113 to i32
  %114 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i90 = call i32 @putc(i32 %conv.i89, %struct._IO_FILE* %114) #9
  %115 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i86 = getelementptr inbounds i8, i8* %0, i64 %115
  %116 = load i8, i8* %arrayidx.i86, align 1, !tbaa !6
  %add.i87 = add i8 %116, -1
  store i8 %add.i87, i8* %arrayidx.i86, align 1, !tbaa !6
  %117 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i84 = getelementptr inbounds i8, i8* %0, i64 %117
  %118 = load i8, i8* %arrayidx.i84, align 1, !tbaa !6
  %add.i85 = add i8 %118, -1
  store i8 %add.i85, i8* %arrayidx.i84, align 1, !tbaa !6
  %119 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i82 = getelementptr inbounds i8, i8* %0, i64 %119
  %120 = load i8, i8* %arrayidx.i82, align 1, !tbaa !6
  %add.i83 = add i8 %120, -1
  store i8 %add.i83, i8* %arrayidx.i82, align 1, !tbaa !6
  %121 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i80 = getelementptr inbounds i8, i8* %0, i64 %121
  %122 = load i8, i8* %arrayidx.i80, align 1, !tbaa !6
  %add.i81 = add i8 %122, -1
  store i8 %add.i81, i8* %arrayidx.i80, align 1, !tbaa !6
  %123 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i78 = getelementptr inbounds i8, i8* %0, i64 %123
  %124 = load i8, i8* %arrayidx.i78, align 1, !tbaa !6
  %add.i79 = add i8 %124, -1
  store i8 %add.i79, i8* %arrayidx.i78, align 1, !tbaa !6
  %125 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i76 = getelementptr inbounds i8, i8* %0, i64 %125
  %126 = load i8, i8* %arrayidx.i76, align 1, !tbaa !6
  %add.i77 = add i8 %126, -1
  store i8 %add.i77, i8* %arrayidx.i76, align 1, !tbaa !6
  %127 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i74 = getelementptr inbounds i8, i8* %0, i64 %127
  %128 = load i8, i8* %arrayidx.i74, align 1, !tbaa !6
  %add.i75 = add i8 %128, -1
  store i8 %add.i75, i8* %arrayidx.i74, align 1, !tbaa !6
  %129 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i72 = getelementptr inbounds i8, i8* %0, i64 %129
  %130 = load i8, i8* %arrayidx.i72, align 1, !tbaa !6
  %add.i73 = add i8 %130, -1
  store i8 %add.i73, i8* %arrayidx.i72, align 1, !tbaa !6
  %131 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i67 = getelementptr inbounds i8, i8* %0, i64 %131
  %132 = load i8, i8* %arrayidx.i67, align 1, !tbaa !6
  %conv.i68 = zext i8 %132 to i32
  %133 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i69 = call i32 @putc(i32 %conv.i68, %struct._IO_FILE* %133) #9
  %134 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i66 = add i64 %134, 1
  store i64 %add.i66, i64* %ptr, align 8, !tbaa !2
  %135 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i65 = add i64 %135, 1
  store i64 %add.i65, i64* %ptr, align 8, !tbaa !2
  %136 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i63 = getelementptr inbounds i8, i8* %0, i64 %136
  %137 = load i8, i8* %arrayidx.i63, align 1, !tbaa !6
  %add.i64 = add i8 %137, 1
  store i8 %add.i64, i8* %arrayidx.i63, align 1, !tbaa !6
  %138 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i58 = getelementptr inbounds i8, i8* %0, i64 %138
  %139 = load i8, i8* %arrayidx.i58, align 1, !tbaa !6
  %conv.i59 = zext i8 %139 to i32
  %140 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i60 = call i32 @putc(i32 %conv.i59, %struct._IO_FILE* %140) #9
  %141 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i57 = add i64 %141, 1
  store i64 %add.i57, i64* %ptr, align 8, !tbaa !2
  %142 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i55 = getelementptr inbounds i8, i8* %0, i64 %142
  %143 = load i8, i8* %arrayidx.i55, align 1, !tbaa !6
  %add.i56 = add i8 %143, 1
  store i8 %add.i56, i8* %arrayidx.i55, align 1, !tbaa !6
  %144 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i53 = getelementptr inbounds i8, i8* %0, i64 %144
  %145 = load i8, i8* %arrayidx.i53, align 1, !tbaa !6
  %add.i54 = add i8 %145, 1
  store i8 %add.i54, i8* %arrayidx.i53, align 1, !tbaa !6
  %146 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i50 = getelementptr inbounds i8, i8* %0, i64 %146
  %147 = load i8, i8* %arrayidx.i50, align 1, !tbaa !6
  %conv.i = zext i8 %147 to i32
  %148 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i = call i32 @putc(i32 %conv.i, %struct._IO_FILE* %148) #9
  ret void

149:                                              ; preds = %152, %21
  %150 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i49 = getelementptr inbounds i8, i8* %0, i64 %150
  %151 = load i8, i8* %arrayidx.i49, align 1, !tbaa !6
  %.not1 = icmp eq i8 %151, 0
  br i1 %.not1, label %181, label %152

152:                                              ; preds = %149
  %153 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i48 = add i64 %153, 1
  store i64 %add.i48, i64* %ptr, align 8, !tbaa !2
  %154 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i46 = getelementptr inbounds i8, i8* %0, i64 %154
  %155 = load i8, i8* %arrayidx.i46, align 1, !tbaa !6
  %add.i47 = add i8 %155, 1
  store i8 %add.i47, i8* %arrayidx.i46, align 1, !tbaa !6
  %156 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i44 = getelementptr inbounds i8, i8* %0, i64 %156
  %157 = load i8, i8* %arrayidx.i44, align 1, !tbaa !6
  %add.i45 = add i8 %157, 1
  store i8 %add.i45, i8* %arrayidx.i44, align 1, !tbaa !6
  %158 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i43 = add i64 %158, 1
  store i64 %add.i43, i64* %ptr, align 8, !tbaa !2
  %159 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i41 = getelementptr inbounds i8, i8* %0, i64 %159
  %160 = load i8, i8* %arrayidx.i41, align 1, !tbaa !6
  %add.i42 = add i8 %160, 1
  store i8 %add.i42, i8* %arrayidx.i41, align 1, !tbaa !6
  %161 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i39 = getelementptr inbounds i8, i8* %0, i64 %161
  %162 = load i8, i8* %arrayidx.i39, align 1, !tbaa !6
  %add.i40 = add i8 %162, 1
  store i8 %add.i40, i8* %arrayidx.i39, align 1, !tbaa !6
  %163 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i37 = getelementptr inbounds i8, i8* %0, i64 %163
  %164 = load i8, i8* %arrayidx.i37, align 1, !tbaa !6
  %add.i38 = add i8 %164, 1
  store i8 %add.i38, i8* %arrayidx.i37, align 1, !tbaa !6
  %165 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i36 = add i64 %165, 1
  store i64 %add.i36, i64* %ptr, align 8, !tbaa !2
  %166 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i34 = getelementptr inbounds i8, i8* %0, i64 %166
  %167 = load i8, i8* %arrayidx.i34, align 1, !tbaa !6
  %add.i35 = add i8 %167, 1
  store i8 %add.i35, i8* %arrayidx.i34, align 1, !tbaa !6
  %168 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i32 = getelementptr inbounds i8, i8* %0, i64 %168
  %169 = load i8, i8* %arrayidx.i32, align 1, !tbaa !6
  %add.i33 = add i8 %169, 1
  store i8 %add.i33, i8* %arrayidx.i32, align 1, !tbaa !6
  %170 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i30 = getelementptr inbounds i8, i8* %0, i64 %170
  %171 = load i8, i8* %arrayidx.i30, align 1, !tbaa !6
  %add.i31 = add i8 %171, 1
  store i8 %add.i31, i8* %arrayidx.i30, align 1, !tbaa !6
  %172 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i29 = add i64 %172, 1
  store i64 %add.i29, i64* %ptr, align 8, !tbaa !2
  %173 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i27 = getelementptr inbounds i8, i8* %0, i64 %173
  %174 = load i8, i8* %arrayidx.i27, align 1, !tbaa !6
  %add.i28 = add i8 %174, 1
  store i8 %add.i28, i8* %arrayidx.i27, align 1, !tbaa !6
  %175 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i26 = add i64 %175, -1
  store i64 %add.i26, i64* %ptr, align 8, !tbaa !2
  %176 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i25 = add i64 %176, -1
  store i64 %add.i25, i64* %ptr, align 8, !tbaa !2
  %177 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i24 = add i64 %177, -1
  store i64 %add.i24, i64* %ptr, align 8, !tbaa !2
  %178 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i23 = add i64 %178, -1
  store i64 %add.i23, i64* %ptr, align 8, !tbaa !2
  %179 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i21 = getelementptr inbounds i8, i8* %0, i64 %179
  %180 = load i8, i8* %arrayidx.i21, align 1, !tbaa !6
  %add.i22 = add i8 %180, -1
  store i8 %add.i22, i8* %arrayidx.i21, align 1, !tbaa !6
  br label %149

181:                                              ; preds = %149
  %182 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i20 = add i64 %182, 1
  store i64 %add.i20, i64* %ptr, align 8, !tbaa !2
  %183 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i18 = getelementptr inbounds i8, i8* %0, i64 %183
  %184 = load i8, i8* %arrayidx.i18, align 1, !tbaa !6
  %add.i19 = add i8 %184, 1
  store i8 %add.i19, i8* %arrayidx.i18, align 1, !tbaa !6
  %185 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i17 = add i64 %185, 1
  store i64 %add.i17, i64* %ptr, align 8, !tbaa !2
  %186 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i15 = getelementptr inbounds i8, i8* %0, i64 %186
  %187 = load i8, i8* %arrayidx.i15, align 1, !tbaa !6
  %add.i16 = add i8 %187, 1
  store i8 %add.i16, i8* %arrayidx.i15, align 1, !tbaa !6
  %188 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i14 = add i64 %188, 1
  store i64 %add.i14, i64* %ptr, align 8, !tbaa !2
  %189 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i12 = getelementptr inbounds i8, i8* %0, i64 %189
  %190 = load i8, i8* %arrayidx.i12, align 1, !tbaa !6
  %add.i13 = add i8 %190, -1
  store i8 %add.i13, i8* %arrayidx.i12, align 1, !tbaa !6
  %191 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i11 = add i64 %191, 1
  store i64 %add.i11, i64* %ptr, align 8, !tbaa !2
  %192 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i10 = add i64 %192, 1
  store i64 %add.i10, i64* %ptr, align 8, !tbaa !2
  %193 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i8 = getelementptr inbounds i8, i8* %0, i64 %193
  %194 = load i8, i8* %arrayidx.i8, align 1, !tbaa !6
  %add.i9 = add i8 %194, 1
  store i8 %add.i9, i8* %arrayidx.i8, align 1, !tbaa !6
  br label %195

195:                                              ; preds = %198, %181
  %196 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i7 = getelementptr inbounds i8, i8* %0, i64 %196
  %197 = load i8, i8* %arrayidx.i7, align 1, !tbaa !6
  %.not2 = icmp eq i8 %197, 0
  br i1 %.not2, label %200, label %198

198:                                              ; preds = %195
  %199 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i6 = add i64 %199, -1
  store i64 %add.i6, i64* %ptr, align 8, !tbaa !2
  br label %195

200:                                              ; preds = %195
  %201 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i5 = add i64 %201, -1
  store i64 %add.i5, i64* %ptr, align 8, !tbaa !2
  %202 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i3 = getelementptr inbounds i8, i8* %0, i64 %202
  %203 = load i8, i8* %arrayidx.i3, align 1, !tbaa !6
  %add.i4 = add i8 %203, -1
  store i8 %add.i4, i8* %arrayidx.i3, align 1, !tbaa !6
  br label %18
}

define void @main() {
  call void @lifted()
  ret void
}

attributes #0 = { alwaysinline nofree norecurse nounwind uwtable willreturn mustprogress "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+x87,-3dnow,-3dnowa,-aes,-avx,-avx2,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-avxvnni,-f16c,-fma,-fma4,-gfni,-kl,-mmx,-pclmul,-sha,-sse,-sse2,-sse3,-sse4.1,-sse4.2,-sse4a,-ssse3,-vaes,-vpclmulqdq,-widekl,-xop" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { alwaysinline nofree nounwind uwtable mustprogress "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+x87,-3dnow,-3dnowa,-aes,-avx,-avx2,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-avxvnni,-f16c,-fma,-fma4,-gfni,-kl,-mmx,-pclmul,-sha,-sse,-sse2,-sse3,-sse4.1,-sse4.2,-sse4a,-ssse3,-vaes,-vpclmulqdq,-widekl,-xop" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { alwaysinline norecurse nounwind readonly uwtable willreturn mustprogress "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+x87,-3dnow,-3dnowa,-aes,-avx,-avx2,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-avxvnni,-f16c,-fma,-fma4,-gfni,-kl,-mmx,-pclmul,-sha,-sse,-sse2,-sse3,-sse4.1,-sse4.2,-sse4a,-ssse3,-vaes,-vpclmulqdq,-widekl,-xop" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+x87,-3dnow,-3dnowa,-aes,-avx,-avx2,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-avxvnni,-f16c,-fma,-fma4,-gfni,-kl,-mmx,-pclmul,-sha,-sse,-sse2,-sse3,-sse4.1,-sse4.2,-sse4a,-ssse3,-vaes,-vpclmulqdq,-widekl,-xop" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nofree nosync nounwind willreturn writeonly }
attributes #6 = { "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+x87,-3dnow,-3dnowa,-aes,-avx,-avx2,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-avxvnni,-f16c,-fma,-fma4,-gfni,-kl,-mmx,-pclmul,-sha,-sse,-sse2,-sse3,-sse4.1,-sse4.2,-sse4a,-ssse3,-vaes,-vpclmulqdq,-widekl,-xop" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nofree nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+x87,-3dnow,-3dnowa,-aes,-avx,-avx2,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-avxvnni,-f16c,-fma,-fma4,-gfni,-kl,-mmx,-pclmul,-sha,-sse,-sse2,-sse3,-sse4.1,-sse4.2,-sse4a,-ssse3,-vaes,-vpclmulqdq,-widekl,-xop" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { alwaysinline }
attributes #9 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.4"}
!2 = !{!3, !3, i64 0}
!3 = !{!"long", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C++ TBAA"}
!6 = !{!4, !4, i64 0}
!7 = !{!8, !8, i64 0}
!8 = !{!"any pointer", !4, i64 0}
