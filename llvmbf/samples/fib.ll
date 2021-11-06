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
  %arrayidx.i95.i = getelementptr inbounds i8, i8* %0, i64 %4
  %5 = load i8, i8* %arrayidx.i95.i, align 1, !tbaa !6
  %add.i96.i = add i8 %5, 1
  store i8 %add.i96.i, i8* %arrayidx.i95.i, align 1, !tbaa !6
  %6 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i101.i = getelementptr inbounds i8, i8* %0, i64 %6
  %7 = load i8, i8* %arrayidx.i101.i, align 1, !tbaa !6
  %add.i102.i = add i8 %7, 1
  store i8 %add.i102.i, i8* %arrayidx.i101.i, align 1, !tbaa !6
  %8 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i159.i = getelementptr inbounds i8, i8* %0, i64 %8
  %9 = load i8, i8* %arrayidx.i159.i, align 1, !tbaa !6
  %add.i160.i = add i8 %9, 1
  store i8 %add.i160.i, i8* %arrayidx.i159.i, align 1, !tbaa !6
  %10 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i291.i = getelementptr inbounds i8, i8* %0, i64 %10
  %11 = load i8, i8* %arrayidx.i291.i, align 1, !tbaa !6
  %add.i292.i = add i8 %11, 1
  store i8 %add.i292.i, i8* %arrayidx.i291.i, align 1, !tbaa !6
  %12 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i766.i = getelementptr inbounds i8, i8* %0, i64 %12
  %13 = load i8, i8* %arrayidx.i766.i, align 1, !tbaa !6
  %add.i767.i = add i8 %13, 1
  store i8 %add.i767.i, i8* %arrayidx.i766.i, align 1, !tbaa !6
  %14 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i764.i = getelementptr inbounds i8, i8* %0, i64 %14
  %15 = load i8, i8* %arrayidx.i764.i, align 1, !tbaa !6
  %add.i765.i = add i8 %15, 1
  store i8 %add.i765.i, i8* %arrayidx.i764.i, align 1, !tbaa !6
  %16 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i762.i = getelementptr inbounds i8, i8* %0, i64 %16
  %17 = load i8, i8* %arrayidx.i762.i, align 1, !tbaa !6
  %add.i763.i = add i8 %17, 1
  store i8 %add.i763.i, i8* %arrayidx.i762.i, align 1, !tbaa !6
  %18 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i760.i = getelementptr inbounds i8, i8* %0, i64 %18
  %19 = load i8, i8* %arrayidx.i760.i, align 1, !tbaa !6
  %add.i761.i = add i8 %19, 1
  store i8 %add.i761.i, i8* %arrayidx.i760.i, align 1, !tbaa !6
  %20 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i758.i = getelementptr inbounds i8, i8* %0, i64 %20
  %21 = load i8, i8* %arrayidx.i758.i, align 1, !tbaa !6
  %add.i759.i = add i8 %21, 1
  store i8 %add.i759.i, i8* %arrayidx.i758.i, align 1, !tbaa !6
  %22 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i756.i = getelementptr inbounds i8, i8* %0, i64 %22
  %23 = load i8, i8* %arrayidx.i756.i, align 1, !tbaa !6
  %add.i757.i = add i8 %23, 1
  store i8 %add.i757.i, i8* %arrayidx.i756.i, align 1, !tbaa !6
  %24 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i755.i = add i64 %24, 1
  store i64 %add.i755.i, i64* %ptr.i, align 8, !tbaa !2
  %25 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i753.i = getelementptr inbounds i8, i8* %0, i64 %25
  %26 = load i8, i8* %arrayidx.i753.i, align 1, !tbaa !6
  %add.i754.i = add i8 %26, 1
  store i8 %add.i754.i, i8* %arrayidx.i753.i, align 1, !tbaa !6
  %27 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i752.i = add i64 %27, 1
  store i64 %add.i752.i, i64* %ptr.i, align 8, !tbaa !2
  %28 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i751.i = add i64 %28, 1
  store i64 %add.i751.i, i64* %ptr.i, align 8, !tbaa !2
  %29 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i750.i = add i64 %29, 1
  store i64 %add.i750.i, i64* %ptr.i, align 8, !tbaa !2
  %30 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i749.i = add i64 %30, 1
  store i64 %add.i749.i, i64* %ptr.i, align 8, !tbaa !2
  %31 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i747.i = getelementptr inbounds i8, i8* %0, i64 %31
  %32 = load i8, i8* %arrayidx.i747.i, align 1, !tbaa !6
  %add.i748.i = add i8 %32, 1
  store i8 %add.i748.i, i8* %arrayidx.i747.i, align 1, !tbaa !6
  %33 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i745.i = getelementptr inbounds i8, i8* %0, i64 %33
  %34 = load i8, i8* %arrayidx.i745.i, align 1, !tbaa !6
  %add.i746.i = add i8 %34, 1
  store i8 %add.i746.i, i8* %arrayidx.i745.i, align 1, !tbaa !6
  %35 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i743.i = getelementptr inbounds i8, i8* %0, i64 %35
  %36 = load i8, i8* %arrayidx.i743.i, align 1, !tbaa !6
  %add.i744.i = add i8 %36, 1
  store i8 %add.i744.i, i8* %arrayidx.i743.i, align 1, !tbaa !6
  %37 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i741.i = getelementptr inbounds i8, i8* %0, i64 %37
  %38 = load i8, i8* %arrayidx.i741.i, align 1, !tbaa !6
  %add.i742.i = add i8 %38, 1
  store i8 %add.i742.i, i8* %arrayidx.i741.i, align 1, !tbaa !6
  %39 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i739.i = getelementptr inbounds i8, i8* %0, i64 %39
  %40 = load i8, i8* %arrayidx.i739.i, align 1, !tbaa !6
  %add.i740.i = add i8 %40, 1
  store i8 %add.i740.i, i8* %arrayidx.i739.i, align 1, !tbaa !6
  %41 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i737.i = getelementptr inbounds i8, i8* %0, i64 %41
  %42 = load i8, i8* %arrayidx.i737.i, align 1, !tbaa !6
  %add.i738.i = add i8 %42, 1
  store i8 %add.i738.i, i8* %arrayidx.i737.i, align 1, !tbaa !6
  %43 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i735.i = getelementptr inbounds i8, i8* %0, i64 %43
  %44 = load i8, i8* %arrayidx.i735.i, align 1, !tbaa !6
  %add.i736.i = add i8 %44, 1
  store i8 %add.i736.i, i8* %arrayidx.i735.i, align 1, !tbaa !6
  %45 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i733.i = getelementptr inbounds i8, i8* %0, i64 %45
  %46 = load i8, i8* %arrayidx.i733.i, align 1, !tbaa !6
  %add.i734.i = add i8 %46, 1
  store i8 %add.i734.i, i8* %arrayidx.i733.i, align 1, !tbaa !6
  %47 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i731.i = getelementptr inbounds i8, i8* %0, i64 %47
  %48 = load i8, i8* %arrayidx.i731.i, align 1, !tbaa !6
  %add.i732.i = add i8 %48, 1
  store i8 %add.i732.i, i8* %arrayidx.i731.i, align 1, !tbaa !6
  %49 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i729.i = getelementptr inbounds i8, i8* %0, i64 %49
  %50 = load i8, i8* %arrayidx.i729.i, align 1, !tbaa !6
  %add.i730.i = add i8 %50, 1
  store i8 %add.i730.i, i8* %arrayidx.i729.i, align 1, !tbaa !6
  %51 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i727.i = getelementptr inbounds i8, i8* %0, i64 %51
  %52 = load i8, i8* %arrayidx.i727.i, align 1, !tbaa !6
  %add.i728.i = add i8 %52, 1
  store i8 %add.i728.i, i8* %arrayidx.i727.i, align 1, !tbaa !6
  %53 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i725.i = getelementptr inbounds i8, i8* %0, i64 %53
  %54 = load i8, i8* %arrayidx.i725.i, align 1, !tbaa !6
  %add.i726.i = add i8 %54, 1
  store i8 %add.i726.i, i8* %arrayidx.i725.i, align 1, !tbaa !6
  %55 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i723.i = getelementptr inbounds i8, i8* %0, i64 %55
  %56 = load i8, i8* %arrayidx.i723.i, align 1, !tbaa !6
  %add.i724.i = add i8 %56, 1
  store i8 %add.i724.i, i8* %arrayidx.i723.i, align 1, !tbaa !6
  %57 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i721.i = getelementptr inbounds i8, i8* %0, i64 %57
  %58 = load i8, i8* %arrayidx.i721.i, align 1, !tbaa !6
  %add.i722.i = add i8 %58, 1
  store i8 %add.i722.i, i8* %arrayidx.i721.i, align 1, !tbaa !6
  %59 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i719.i = getelementptr inbounds i8, i8* %0, i64 %59
  %60 = load i8, i8* %arrayidx.i719.i, align 1, !tbaa !6
  %add.i720.i = add i8 %60, 1
  store i8 %add.i720.i, i8* %arrayidx.i719.i, align 1, !tbaa !6
  %61 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i717.i = getelementptr inbounds i8, i8* %0, i64 %61
  %62 = load i8, i8* %arrayidx.i717.i, align 1, !tbaa !6
  %add.i718.i = add i8 %62, 1
  store i8 %add.i718.i, i8* %arrayidx.i717.i, align 1, !tbaa !6
  %63 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i715.i = getelementptr inbounds i8, i8* %0, i64 %63
  %64 = load i8, i8* %arrayidx.i715.i, align 1, !tbaa !6
  %add.i716.i = add i8 %64, 1
  store i8 %add.i716.i, i8* %arrayidx.i715.i, align 1, !tbaa !6
  %65 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i713.i = getelementptr inbounds i8, i8* %0, i64 %65
  %66 = load i8, i8* %arrayidx.i713.i, align 1, !tbaa !6
  %add.i714.i = add i8 %66, 1
  store i8 %add.i714.i, i8* %arrayidx.i713.i, align 1, !tbaa !6
  %67 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i711.i = getelementptr inbounds i8, i8* %0, i64 %67
  %68 = load i8, i8* %arrayidx.i711.i, align 1, !tbaa !6
  %add.i712.i = add i8 %68, 1
  store i8 %add.i712.i, i8* %arrayidx.i711.i, align 1, !tbaa !6
  %69 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i709.i = getelementptr inbounds i8, i8* %0, i64 %69
  %70 = load i8, i8* %arrayidx.i709.i, align 1, !tbaa !6
  %add.i710.i = add i8 %70, 1
  store i8 %add.i710.i, i8* %arrayidx.i709.i, align 1, !tbaa !6
  %71 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i707.i = getelementptr inbounds i8, i8* %0, i64 %71
  %72 = load i8, i8* %arrayidx.i707.i, align 1, !tbaa !6
  %add.i708.i = add i8 %72, 1
  store i8 %add.i708.i, i8* %arrayidx.i707.i, align 1, !tbaa !6
  %73 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i705.i = getelementptr inbounds i8, i8* %0, i64 %73
  %74 = load i8, i8* %arrayidx.i705.i, align 1, !tbaa !6
  %add.i706.i = add i8 %74, 1
  store i8 %add.i706.i, i8* %arrayidx.i705.i, align 1, !tbaa !6
  %75 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i703.i = getelementptr inbounds i8, i8* %0, i64 %75
  %76 = load i8, i8* %arrayidx.i703.i, align 1, !tbaa !6
  %add.i704.i = add i8 %76, 1
  store i8 %add.i704.i, i8* %arrayidx.i703.i, align 1, !tbaa !6
  %77 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i701.i = getelementptr inbounds i8, i8* %0, i64 %77
  %78 = load i8, i8* %arrayidx.i701.i, align 1, !tbaa !6
  %add.i702.i = add i8 %78, 1
  store i8 %add.i702.i, i8* %arrayidx.i701.i, align 1, !tbaa !6
  %79 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i699.i = getelementptr inbounds i8, i8* %0, i64 %79
  %80 = load i8, i8* %arrayidx.i699.i, align 1, !tbaa !6
  %add.i700.i = add i8 %80, 1
  store i8 %add.i700.i, i8* %arrayidx.i699.i, align 1, !tbaa !6
  %81 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i697.i = getelementptr inbounds i8, i8* %0, i64 %81
  %82 = load i8, i8* %arrayidx.i697.i, align 1, !tbaa !6
  %add.i698.i = add i8 %82, 1
  store i8 %add.i698.i, i8* %arrayidx.i697.i, align 1, !tbaa !6
  %83 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i695.i = getelementptr inbounds i8, i8* %0, i64 %83
  %84 = load i8, i8* %arrayidx.i695.i, align 1, !tbaa !6
  %add.i696.i = add i8 %84, 1
  store i8 %add.i696.i, i8* %arrayidx.i695.i, align 1, !tbaa !6
  %85 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i693.i = getelementptr inbounds i8, i8* %0, i64 %85
  %86 = load i8, i8* %arrayidx.i693.i, align 1, !tbaa !6
  %add.i694.i = add i8 %86, 1
  store i8 %add.i694.i, i8* %arrayidx.i693.i, align 1, !tbaa !6
  %87 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i691.i = getelementptr inbounds i8, i8* %0, i64 %87
  %88 = load i8, i8* %arrayidx.i691.i, align 1, !tbaa !6
  %add.i692.i = add i8 %88, 1
  store i8 %add.i692.i, i8* %arrayidx.i691.i, align 1, !tbaa !6
  %89 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i689.i = getelementptr inbounds i8, i8* %0, i64 %89
  %90 = load i8, i8* %arrayidx.i689.i, align 1, !tbaa !6
  %add.i690.i = add i8 %90, 1
  store i8 %add.i690.i, i8* %arrayidx.i689.i, align 1, !tbaa !6
  %91 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i687.i = getelementptr inbounds i8, i8* %0, i64 %91
  %92 = load i8, i8* %arrayidx.i687.i, align 1, !tbaa !6
  %add.i688.i = add i8 %92, 1
  store i8 %add.i688.i, i8* %arrayidx.i687.i, align 1, !tbaa !6
  %93 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i685.i = getelementptr inbounds i8, i8* %0, i64 %93
  %94 = load i8, i8* %arrayidx.i685.i, align 1, !tbaa !6
  %add.i686.i = add i8 %94, 1
  store i8 %add.i686.i, i8* %arrayidx.i685.i, align 1, !tbaa !6
  %95 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i683.i = getelementptr inbounds i8, i8* %0, i64 %95
  %96 = load i8, i8* %arrayidx.i683.i, align 1, !tbaa !6
  %add.i684.i = add i8 %96, 1
  store i8 %add.i684.i, i8* %arrayidx.i683.i, align 1, !tbaa !6
  %97 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i681.i = getelementptr inbounds i8, i8* %0, i64 %97
  %98 = load i8, i8* %arrayidx.i681.i, align 1, !tbaa !6
  %add.i682.i = add i8 %98, 1
  store i8 %add.i682.i, i8* %arrayidx.i681.i, align 1, !tbaa !6
  %99 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i679.i = getelementptr inbounds i8, i8* %0, i64 %99
  %100 = load i8, i8* %arrayidx.i679.i, align 1, !tbaa !6
  %add.i680.i = add i8 %100, 1
  store i8 %add.i680.i, i8* %arrayidx.i679.i, align 1, !tbaa !6
  %101 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i677.i = getelementptr inbounds i8, i8* %0, i64 %101
  %102 = load i8, i8* %arrayidx.i677.i, align 1, !tbaa !6
  %add.i678.i = add i8 %102, 1
  store i8 %add.i678.i, i8* %arrayidx.i677.i, align 1, !tbaa !6
  %103 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i675.i = getelementptr inbounds i8, i8* %0, i64 %103
  %104 = load i8, i8* %arrayidx.i675.i, align 1, !tbaa !6
  %add.i676.i = add i8 %104, 1
  store i8 %add.i676.i, i8* %arrayidx.i675.i, align 1, !tbaa !6
  %105 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i673.i = getelementptr inbounds i8, i8* %0, i64 %105
  %106 = load i8, i8* %arrayidx.i673.i, align 1, !tbaa !6
  %add.i674.i = add i8 %106, 1
  store i8 %add.i674.i, i8* %arrayidx.i673.i, align 1, !tbaa !6
  %107 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i671.i = getelementptr inbounds i8, i8* %0, i64 %107
  %108 = load i8, i8* %arrayidx.i671.i, align 1, !tbaa !6
  %add.i672.i = add i8 %108, 1
  store i8 %add.i672.i, i8* %arrayidx.i671.i, align 1, !tbaa !6
  %109 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i669.i = getelementptr inbounds i8, i8* %0, i64 %109
  %110 = load i8, i8* %arrayidx.i669.i, align 1, !tbaa !6
  %add.i670.i = add i8 %110, 1
  store i8 %add.i670.i, i8* %arrayidx.i669.i, align 1, !tbaa !6
  %111 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i667.i = getelementptr inbounds i8, i8* %0, i64 %111
  %112 = load i8, i8* %arrayidx.i667.i, align 1, !tbaa !6
  %add.i668.i = add i8 %112, 1
  store i8 %add.i668.i, i8* %arrayidx.i667.i, align 1, !tbaa !6
  %113 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i665.i = getelementptr inbounds i8, i8* %0, i64 %113
  %114 = load i8, i8* %arrayidx.i665.i, align 1, !tbaa !6
  %add.i666.i = add i8 %114, 1
  store i8 %add.i666.i, i8* %arrayidx.i665.i, align 1, !tbaa !6
  %115 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i663.i = getelementptr inbounds i8, i8* %0, i64 %115
  %116 = load i8, i8* %arrayidx.i663.i, align 1, !tbaa !6
  %add.i664.i = add i8 %116, 1
  store i8 %add.i664.i, i8* %arrayidx.i663.i, align 1, !tbaa !6
  %117 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i661.i = getelementptr inbounds i8, i8* %0, i64 %117
  %118 = load i8, i8* %arrayidx.i661.i, align 1, !tbaa !6
  %add.i662.i = add i8 %118, 1
  store i8 %add.i662.i, i8* %arrayidx.i661.i, align 1, !tbaa !6
  %119 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i660.i = add i64 %119, 1
  store i64 %add.i660.i, i64* %ptr.i, align 8, !tbaa !2
  %120 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i658.i = getelementptr inbounds i8, i8* %0, i64 %120
  %121 = load i8, i8* %arrayidx.i658.i, align 1, !tbaa !6
  %add.i659.i = add i8 %121, 1
  store i8 %add.i659.i, i8* %arrayidx.i658.i, align 1, !tbaa !6
  %122 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i656.i = getelementptr inbounds i8, i8* %0, i64 %122
  %123 = load i8, i8* %arrayidx.i656.i, align 1, !tbaa !6
  %add.i657.i = add i8 %123, 1
  store i8 %add.i657.i, i8* %arrayidx.i656.i, align 1, !tbaa !6
  %124 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i654.i = getelementptr inbounds i8, i8* %0, i64 %124
  %125 = load i8, i8* %arrayidx.i654.i, align 1, !tbaa !6
  %add.i655.i = add i8 %125, 1
  store i8 %add.i655.i, i8* %arrayidx.i654.i, align 1, !tbaa !6
  %126 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i652.i = getelementptr inbounds i8, i8* %0, i64 %126
  %127 = load i8, i8* %arrayidx.i652.i, align 1, !tbaa !6
  %add.i653.i = add i8 %127, 1
  store i8 %add.i653.i, i8* %arrayidx.i652.i, align 1, !tbaa !6
  %128 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i650.i = getelementptr inbounds i8, i8* %0, i64 %128
  %129 = load i8, i8* %arrayidx.i650.i, align 1, !tbaa !6
  %add.i651.i = add i8 %129, 1
  store i8 %add.i651.i, i8* %arrayidx.i650.i, align 1, !tbaa !6
  %130 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i648.i = getelementptr inbounds i8, i8* %0, i64 %130
  %131 = load i8, i8* %arrayidx.i648.i, align 1, !tbaa !6
  %add.i649.i = add i8 %131, 1
  store i8 %add.i649.i, i8* %arrayidx.i648.i, align 1, !tbaa !6
  %132 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i646.i = getelementptr inbounds i8, i8* %0, i64 %132
  %133 = load i8, i8* %arrayidx.i646.i, align 1, !tbaa !6
  %add.i647.i = add i8 %133, 1
  store i8 %add.i647.i, i8* %arrayidx.i646.i, align 1, !tbaa !6
  %134 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i644.i = getelementptr inbounds i8, i8* %0, i64 %134
  %135 = load i8, i8* %arrayidx.i644.i, align 1, !tbaa !6
  %add.i645.i = add i8 %135, 1
  store i8 %add.i645.i, i8* %arrayidx.i644.i, align 1, !tbaa !6
  %136 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i642.i = getelementptr inbounds i8, i8* %0, i64 %136
  %137 = load i8, i8* %arrayidx.i642.i, align 1, !tbaa !6
  %add.i643.i = add i8 %137, 1
  store i8 %add.i643.i, i8* %arrayidx.i642.i, align 1, !tbaa !6
  %138 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i640.i = getelementptr inbounds i8, i8* %0, i64 %138
  %139 = load i8, i8* %arrayidx.i640.i, align 1, !tbaa !6
  %add.i641.i = add i8 %139, 1
  store i8 %add.i641.i, i8* %arrayidx.i640.i, align 1, !tbaa !6
  %140 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i638.i = getelementptr inbounds i8, i8* %0, i64 %140
  %141 = load i8, i8* %arrayidx.i638.i, align 1, !tbaa !6
  %add.i639.i = add i8 %141, 1
  store i8 %add.i639.i, i8* %arrayidx.i638.i, align 1, !tbaa !6
  %142 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i636.i = getelementptr inbounds i8, i8* %0, i64 %142
  %143 = load i8, i8* %arrayidx.i636.i, align 1, !tbaa !6
  %add.i637.i = add i8 %143, 1
  store i8 %add.i637.i, i8* %arrayidx.i636.i, align 1, !tbaa !6
  %144 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i634.i = getelementptr inbounds i8, i8* %0, i64 %144
  %145 = load i8, i8* %arrayidx.i634.i, align 1, !tbaa !6
  %add.i635.i = add i8 %145, 1
  store i8 %add.i635.i, i8* %arrayidx.i634.i, align 1, !tbaa !6
  %146 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i632.i = getelementptr inbounds i8, i8* %0, i64 %146
  %147 = load i8, i8* %arrayidx.i632.i, align 1, !tbaa !6
  %add.i633.i = add i8 %147, 1
  store i8 %add.i633.i, i8* %arrayidx.i632.i, align 1, !tbaa !6
  %148 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i630.i = getelementptr inbounds i8, i8* %0, i64 %148
  %149 = load i8, i8* %arrayidx.i630.i, align 1, !tbaa !6
  %add.i631.i = add i8 %149, 1
  store i8 %add.i631.i, i8* %arrayidx.i630.i, align 1, !tbaa !6
  %150 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i628.i = getelementptr inbounds i8, i8* %0, i64 %150
  %151 = load i8, i8* %arrayidx.i628.i, align 1, !tbaa !6
  %add.i629.i = add i8 %151, 1
  store i8 %add.i629.i, i8* %arrayidx.i628.i, align 1, !tbaa !6
  %152 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i626.i = getelementptr inbounds i8, i8* %0, i64 %152
  %153 = load i8, i8* %arrayidx.i626.i, align 1, !tbaa !6
  %add.i627.i = add i8 %153, 1
  store i8 %add.i627.i, i8* %arrayidx.i626.i, align 1, !tbaa !6
  %154 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i624.i = getelementptr inbounds i8, i8* %0, i64 %154
  %155 = load i8, i8* %arrayidx.i624.i, align 1, !tbaa !6
  %add.i625.i = add i8 %155, 1
  store i8 %add.i625.i, i8* %arrayidx.i624.i, align 1, !tbaa !6
  %156 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i622.i = getelementptr inbounds i8, i8* %0, i64 %156
  %157 = load i8, i8* %arrayidx.i622.i, align 1, !tbaa !6
  %add.i623.i = add i8 %157, 1
  store i8 %add.i623.i, i8* %arrayidx.i622.i, align 1, !tbaa !6
  %158 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i620.i = getelementptr inbounds i8, i8* %0, i64 %158
  %159 = load i8, i8* %arrayidx.i620.i, align 1, !tbaa !6
  %add.i621.i = add i8 %159, 1
  store i8 %add.i621.i, i8* %arrayidx.i620.i, align 1, !tbaa !6
  %160 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i618.i = getelementptr inbounds i8, i8* %0, i64 %160
  %161 = load i8, i8* %arrayidx.i618.i, align 1, !tbaa !6
  %add.i619.i = add i8 %161, 1
  store i8 %add.i619.i, i8* %arrayidx.i618.i, align 1, !tbaa !6
  %162 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i616.i = getelementptr inbounds i8, i8* %0, i64 %162
  %163 = load i8, i8* %arrayidx.i616.i, align 1, !tbaa !6
  %add.i617.i = add i8 %163, 1
  store i8 %add.i617.i, i8* %arrayidx.i616.i, align 1, !tbaa !6
  %164 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i614.i = getelementptr inbounds i8, i8* %0, i64 %164
  %165 = load i8, i8* %arrayidx.i614.i, align 1, !tbaa !6
  %add.i615.i = add i8 %165, 1
  store i8 %add.i615.i, i8* %arrayidx.i614.i, align 1, !tbaa !6
  %166 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i612.i = getelementptr inbounds i8, i8* %0, i64 %166
  %167 = load i8, i8* %arrayidx.i612.i, align 1, !tbaa !6
  %add.i613.i = add i8 %167, 1
  store i8 %add.i613.i, i8* %arrayidx.i612.i, align 1, !tbaa !6
  %168 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i610.i = getelementptr inbounds i8, i8* %0, i64 %168
  %169 = load i8, i8* %arrayidx.i610.i, align 1, !tbaa !6
  %add.i611.i = add i8 %169, 1
  store i8 %add.i611.i, i8* %arrayidx.i610.i, align 1, !tbaa !6
  %170 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i608.i = getelementptr inbounds i8, i8* %0, i64 %170
  %171 = load i8, i8* %arrayidx.i608.i, align 1, !tbaa !6
  %add.i609.i = add i8 %171, 1
  store i8 %add.i609.i, i8* %arrayidx.i608.i, align 1, !tbaa !6
  %172 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i606.i = getelementptr inbounds i8, i8* %0, i64 %172
  %173 = load i8, i8* %arrayidx.i606.i, align 1, !tbaa !6
  %add.i607.i = add i8 %173, 1
  store i8 %add.i607.i, i8* %arrayidx.i606.i, align 1, !tbaa !6
  %174 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i604.i = getelementptr inbounds i8, i8* %0, i64 %174
  %175 = load i8, i8* %arrayidx.i604.i, align 1, !tbaa !6
  %add.i605.i = add i8 %175, 1
  store i8 %add.i605.i, i8* %arrayidx.i604.i, align 1, !tbaa !6
  %176 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i602.i = getelementptr inbounds i8, i8* %0, i64 %176
  %177 = load i8, i8* %arrayidx.i602.i, align 1, !tbaa !6
  %add.i603.i = add i8 %177, 1
  store i8 %add.i603.i, i8* %arrayidx.i602.i, align 1, !tbaa !6
  %178 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i600.i = getelementptr inbounds i8, i8* %0, i64 %178
  %179 = load i8, i8* %arrayidx.i600.i, align 1, !tbaa !6
  %add.i601.i = add i8 %179, 1
  store i8 %add.i601.i, i8* %arrayidx.i600.i, align 1, !tbaa !6
  %180 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i598.i = getelementptr inbounds i8, i8* %0, i64 %180
  %181 = load i8, i8* %arrayidx.i598.i, align 1, !tbaa !6
  %add.i599.i = add i8 %181, 1
  store i8 %add.i599.i, i8* %arrayidx.i598.i, align 1, !tbaa !6
  %182 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i596.i = getelementptr inbounds i8, i8* %0, i64 %182
  %183 = load i8, i8* %arrayidx.i596.i, align 1, !tbaa !6
  %add.i597.i = add i8 %183, 1
  store i8 %add.i597.i, i8* %arrayidx.i596.i, align 1, !tbaa !6
  %184 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i595.i = add i64 %184, -1
  store i64 %add.i595.i, i64* %ptr.i, align 8, !tbaa !2
  %185 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i594.i = add i64 %185, -1
  store i64 %add.i594.i, i64* %ptr.i, align 8, !tbaa !2
  %186 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i593.i = add i64 %186, -1
  store i64 %add.i593.i, i64* %ptr.i, align 8, !tbaa !2
  %187 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i592.i = add i64 %187, -1
  store i64 %add.i592.i, i64* %ptr.i, align 8, !tbaa !2
  %188 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i591.i = add i64 %188, -1
  store i64 %add.i591.i, i64* %ptr.i, align 8, !tbaa !2
  %189 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i590.i = add i64 %189, -1
  store i64 %add.i590.i, i64* %ptr.i, align 8, !tbaa !2
  br label %190

190:                                              ; preds = %844, %entry
  %191 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i589.i = getelementptr inbounds i8, i8* %0, i64 %191
  %192 = load i8, i8* %arrayidx.i589.i, align 1, !tbaa !6
  %.not.i = icmp eq i8 %192, 0
  br i1 %.not.i, label %hooked_stub.exit, label %193

193:                                              ; preds = %190
  %194 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i588.i = add i64 %194, 1
  store i64 %add.i588.i, i64* %ptr.i, align 8, !tbaa !2
  br label %195

195:                                              ; preds = %198, %193
  %196 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i587.i = getelementptr inbounds i8, i8* %0, i64 %196
  %197 = load i8, i8* %arrayidx.i587.i, align 1, !tbaa !6
  %.not1.i = icmp eq i8 %197, 0
  br i1 %.not1.i, label %219, label %198

198:                                              ; preds = %195
  %199 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i586.i = add i64 %199, 1
  store i64 %add.i586.i, i64* %ptr.i, align 8, !tbaa !2
  %200 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i585.i = add i64 %200, 1
  store i64 %add.i585.i, i64* %ptr.i, align 8, !tbaa !2
  %201 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i584.i = add i64 %201, 1
  store i64 %add.i584.i, i64* %ptr.i, align 8, !tbaa !2
  %202 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i583.i = add i64 %202, 1
  store i64 %add.i583.i, i64* %ptr.i, align 8, !tbaa !2
  %203 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i582.i = add i64 %203, 1
  store i64 %add.i582.i, i64* %ptr.i, align 8, !tbaa !2
  %204 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i581.i = add i64 %204, 1
  store i64 %add.i581.i, i64* %ptr.i, align 8, !tbaa !2
  %205 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i579.i = getelementptr inbounds i8, i8* %0, i64 %205
  %206 = load i8, i8* %arrayidx.i579.i, align 1, !tbaa !6
  %add.i580.i = add i8 %206, 1
  store i8 %add.i580.i, i8* %arrayidx.i579.i, align 1, !tbaa !6
  %207 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i578.i = add i64 %207, 1
  store i64 %add.i578.i, i64* %ptr.i, align 8, !tbaa !2
  %208 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i576.i = getelementptr inbounds i8, i8* %0, i64 %208
  %209 = load i8, i8* %arrayidx.i576.i, align 1, !tbaa !6
  %add.i577.i = add i8 %209, 1
  store i8 %add.i577.i, i8* %arrayidx.i576.i, align 1, !tbaa !6
  %210 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i575.i = add i64 %210, -1
  store i64 %add.i575.i, i64* %ptr.i, align 8, !tbaa !2
  %211 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i574.i = add i64 %211, -1
  store i64 %add.i574.i, i64* %ptr.i, align 8, !tbaa !2
  %212 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i573.i = add i64 %212, -1
  store i64 %add.i573.i, i64* %ptr.i, align 8, !tbaa !2
  %213 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i572.i = add i64 %213, -1
  store i64 %add.i572.i, i64* %ptr.i, align 8, !tbaa !2
  %214 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i571.i = add i64 %214, -1
  store i64 %add.i571.i, i64* %ptr.i, align 8, !tbaa !2
  %215 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i570.i = add i64 %215, -1
  store i64 %add.i570.i, i64* %ptr.i, align 8, !tbaa !2
  %216 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i569.i = add i64 %216, -1
  store i64 %add.i569.i, i64* %ptr.i, align 8, !tbaa !2
  %217 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i567.i = getelementptr inbounds i8, i8* %0, i64 %217
  %218 = load i8, i8* %arrayidx.i567.i, align 1, !tbaa !6
  %add.i568.i = add i8 %218, -1
  store i8 %add.i568.i, i8* %arrayidx.i567.i, align 1, !tbaa !6
  br label %195

219:                                              ; preds = %195
  %220 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i566.i = add i64 %220, 1
  store i64 %add.i566.i, i64* %ptr.i, align 8, !tbaa !2
  %221 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i565.i = add i64 %221, 1
  store i64 %add.i565.i, i64* %ptr.i, align 8, !tbaa !2
  %222 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i564.i = add i64 %222, 1
  store i64 %add.i564.i, i64* %ptr.i, align 8, !tbaa !2
  %223 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i563.i = add i64 %223, 1
  store i64 %add.i563.i, i64* %ptr.i, align 8, !tbaa !2
  %224 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i562.i = add i64 %224, 1
  store i64 %add.i562.i, i64* %ptr.i, align 8, !tbaa !2
  %225 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i561.i = add i64 %225, 1
  store i64 %add.i561.i, i64* %ptr.i, align 8, !tbaa !2
  %226 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i560.i = add i64 %226, 1
  store i64 %add.i560.i, i64* %ptr.i, align 8, !tbaa !2
  br label %227

227:                                              ; preds = %230, %219
  %228 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i559.i = getelementptr inbounds i8, i8* %0, i64 %228
  %229 = load i8, i8* %arrayidx.i559.i, align 1, !tbaa !6
  %.not2.i = icmp eq i8 %229, 0
  br i1 %.not2.i, label %.preheader.preheader.i, label %230

.preheader.preheader.i:                           ; preds = %227
  br label %.preheader.i

230:                                              ; preds = %227
  %231 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i558.i = add i64 %231, -1
  store i64 %add.i558.i, i64* %ptr.i, align 8, !tbaa !2
  %232 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i557.i = add i64 %232, -1
  store i64 %add.i557.i, i64* %ptr.i, align 8, !tbaa !2
  %233 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i556.i = add i64 %233, -1
  store i64 %add.i556.i, i64* %ptr.i, align 8, !tbaa !2
  %234 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i555.i = add i64 %234, -1
  store i64 %add.i555.i, i64* %ptr.i, align 8, !tbaa !2
  %235 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i554.i = add i64 %235, -1
  store i64 %add.i554.i, i64* %ptr.i, align 8, !tbaa !2
  %236 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i553.i = add i64 %236, -1
  store i64 %add.i553.i, i64* %ptr.i, align 8, !tbaa !2
  %237 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i552.i = add i64 %237, -1
  store i64 %add.i552.i, i64* %ptr.i, align 8, !tbaa !2
  %238 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i550.i = getelementptr inbounds i8, i8* %0, i64 %238
  %239 = load i8, i8* %arrayidx.i550.i, align 1, !tbaa !6
  %add.i551.i = add i8 %239, 1
  store i8 %add.i551.i, i8* %arrayidx.i550.i, align 1, !tbaa !6
  %240 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i549.i = add i64 %240, 1
  store i64 %add.i549.i, i64* %ptr.i, align 8, !tbaa !2
  %241 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i548.i = add i64 %241, 1
  store i64 %add.i548.i, i64* %ptr.i, align 8, !tbaa !2
  %242 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i547.i = add i64 %242, 1
  store i64 %add.i547.i, i64* %ptr.i, align 8, !tbaa !2
  %243 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i546.i = add i64 %243, 1
  store i64 %add.i546.i, i64* %ptr.i, align 8, !tbaa !2
  %244 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i545.i = add i64 %244, 1
  store i64 %add.i545.i, i64* %ptr.i, align 8, !tbaa !2
  %245 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i544.i = add i64 %245, 1
  store i64 %add.i544.i, i64* %ptr.i, align 8, !tbaa !2
  %246 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i543.i = add i64 %246, 1
  store i64 %add.i543.i, i64* %ptr.i, align 8, !tbaa !2
  %247 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i541.i = getelementptr inbounds i8, i8* %0, i64 %247
  %248 = load i8, i8* %arrayidx.i541.i, align 1, !tbaa !6
  %add.i542.i = add i8 %248, -1
  store i8 %add.i542.i, i8* %arrayidx.i541.i, align 1, !tbaa !6
  br label %227

.preheader.i:                                     ; preds = %446, %.preheader.preheader.i
  %249 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i540.i = add i64 %249, -1
  store i64 %add.i540.i, i64* %ptr.i, align 8, !tbaa !2
  %250 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i539.i = getelementptr inbounds i8, i8* %0, i64 %250
  %251 = load i8, i8* %arrayidx.i539.i, align 1, !tbaa !6
  %.not3.i = icmp eq i8 %251, 0
  br i1 %.not3.i, label %274, label %252

252:                                              ; preds = %.preheader.i
  %253 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i538.i = add i64 %253, 1
  store i64 %add.i538.i, i64* %ptr.i, align 8, !tbaa !2
  %254 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i536.i = getelementptr inbounds i8, i8* %0, i64 %254
  %255 = load i8, i8* %arrayidx.i536.i, align 1, !tbaa !6
  %add.i537.i = add i8 %255, 1
  store i8 %add.i537.i, i8* %arrayidx.i536.i, align 1, !tbaa !6
  %256 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i534.i = getelementptr inbounds i8, i8* %0, i64 %256
  %257 = load i8, i8* %arrayidx.i534.i, align 1, !tbaa !6
  %add.i535.i = add i8 %257, 1
  store i8 %add.i535.i, i8* %arrayidx.i534.i, align 1, !tbaa !6
  %258 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i532.i = getelementptr inbounds i8, i8* %0, i64 %258
  %259 = load i8, i8* %arrayidx.i532.i, align 1, !tbaa !6
  %add.i533.i = add i8 %259, 1
  store i8 %add.i533.i, i8* %arrayidx.i532.i, align 1, !tbaa !6
  %260 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i530.i = getelementptr inbounds i8, i8* %0, i64 %260
  %261 = load i8, i8* %arrayidx.i530.i, align 1, !tbaa !6
  %add.i531.i = add i8 %261, 1
  store i8 %add.i531.i, i8* %arrayidx.i530.i, align 1, !tbaa !6
  %262 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i528.i = getelementptr inbounds i8, i8* %0, i64 %262
  %263 = load i8, i8* %arrayidx.i528.i, align 1, !tbaa !6
  %add.i529.i = add i8 %263, 1
  store i8 %add.i529.i, i8* %arrayidx.i528.i, align 1, !tbaa !6
  %264 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i526.i = getelementptr inbounds i8, i8* %0, i64 %264
  %265 = load i8, i8* %arrayidx.i526.i, align 1, !tbaa !6
  %add.i527.i = add i8 %265, 1
  store i8 %add.i527.i, i8* %arrayidx.i526.i, align 1, !tbaa !6
  %266 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i524.i = getelementptr inbounds i8, i8* %0, i64 %266
  %267 = load i8, i8* %arrayidx.i524.i, align 1, !tbaa !6
  %add.i525.i = add i8 %267, 1
  store i8 %add.i525.i, i8* %arrayidx.i524.i, align 1, !tbaa !6
  %268 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i522.i = getelementptr inbounds i8, i8* %0, i64 %268
  %269 = load i8, i8* %arrayidx.i522.i, align 1, !tbaa !6
  %add.i523.i = add i8 %269, 1
  store i8 %add.i523.i, i8* %arrayidx.i522.i, align 1, !tbaa !6
  %270 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i520.i = getelementptr inbounds i8, i8* %0, i64 %270
  %271 = load i8, i8* %arrayidx.i520.i, align 1, !tbaa !6
  %add.i521.i = add i8 %271, 1
  store i8 %add.i521.i, i8* %arrayidx.i520.i, align 1, !tbaa !6
  %272 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i518.i = getelementptr inbounds i8, i8* %0, i64 %272
  %273 = load i8, i8* %arrayidx.i518.i, align 1, !tbaa !6
  %add.i519.i = add i8 %273, 1
  store i8 %add.i519.i, i8* %arrayidx.i518.i, align 1, !tbaa !6
  br label %280

274:                                              ; preds = %.preheader.i
  %275 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i517.i = add i64 %275, 1
  store i64 %add.i517.i, i64* %ptr.i, align 8, !tbaa !2
  %276 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i516.i = add i64 %276, 1
  store i64 %add.i516.i, i64* %ptr.i, align 8, !tbaa !2
  %277 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i515.i = add i64 %277, 1
  store i64 %add.i515.i, i64* %ptr.i, align 8, !tbaa !2
  %278 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i514.i = add i64 %278, 1
  store i64 %add.i514.i, i64* %ptr.i, align 8, !tbaa !2
  %279 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i513.i = add i64 %279, 1
  store i64 %add.i513.i, i64* %ptr.i, align 8, !tbaa !2
  br label %.loopexit36.i

280:                                              ; preds = %353, %252
  %281 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i512.i = getelementptr inbounds i8, i8* %0, i64 %281
  %282 = load i8, i8* %arrayidx.i512.i, align 1, !tbaa !6
  %.not16.i = icmp eq i8 %282, 0
  br i1 %.not16.i, label %286, label %283

283:                                              ; preds = %280
  %284 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i510.i = getelementptr inbounds i8, i8* %0, i64 %284
  %285 = load i8, i8* %arrayidx.i510.i, align 1, !tbaa !6
  %add.i511.i = add i8 %285, -1
  store i8 %add.i511.i, i8* %arrayidx.i510.i, align 1, !tbaa !6
  br label %290

286:                                              ; preds = %280
  %287 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i509.i = add i64 %287, 1
  store i64 %add.i509.i, i64* %ptr.i, align 8, !tbaa !2
  %288 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i508.i = add i64 %288, 1
  store i64 %add.i508.i, i64* %ptr.i, align 8, !tbaa !2
  %289 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i507.i = add i64 %289, 1
  store i64 %add.i507.i, i64* %ptr.i, align 8, !tbaa !2
  br label %379

290:                                              ; preds = %296, %283
  %291 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i506.i = add i64 %291, -1
  store i64 %add.i506.i, i64* %ptr.i, align 8, !tbaa !2
  %292 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i504.i = getelementptr inbounds i8, i8* %0, i64 %292
  %293 = load i8, i8* %arrayidx.i504.i, align 1, !tbaa !6
  %add.i505.i = add i8 %293, -1
  store i8 %add.i505.i, i8* %arrayidx.i504.i, align 1, !tbaa !6
  %294 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i503.i = getelementptr inbounds i8, i8* %0, i64 %294
  %295 = load i8, i8* %arrayidx.i503.i, align 1, !tbaa !6
  %.not24.i = icmp eq i8 %295, 0
  br i1 %.not24.i, label %306, label %296

296:                                              ; preds = %290
  %297 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i502.i = add i64 %297, 1
  store i64 %add.i502.i, i64* %ptr.i, align 8, !tbaa !2
  %298 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i501.i = add i64 %298, 1
  store i64 %add.i501.i, i64* %ptr.i, align 8, !tbaa !2
  %299 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i499.i = getelementptr inbounds i8, i8* %0, i64 %299
  %300 = load i8, i8* %arrayidx.i499.i, align 1, !tbaa !6
  %add.i500.i = add i8 %300, 1
  store i8 %add.i500.i, i8* %arrayidx.i499.i, align 1, !tbaa !6
  %301 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i498.i = add i64 %301, 1
  store i64 %add.i498.i, i64* %ptr.i, align 8, !tbaa !2
  %302 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i496.i = getelementptr inbounds i8, i8* %0, i64 %302
  %303 = load i8, i8* %arrayidx.i496.i, align 1, !tbaa !6
  %add.i497.i = add i8 %303, 1
  store i8 %add.i497.i, i8* %arrayidx.i496.i, align 1, !tbaa !6
  %304 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i495.i = add i64 %304, -1
  store i64 %add.i495.i, i64* %ptr.i, align 8, !tbaa !2
  %305 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i494.i = add i64 %305, -1
  store i64 %add.i494.i, i64* %ptr.i, align 8, !tbaa !2
  br label %290

306:                                              ; preds = %290
  %307 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i493.i = add i64 %307, 1
  store i64 %add.i493.i, i64* %ptr.i, align 8, !tbaa !2
  %308 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i492.i = add i64 %308, 1
  store i64 %add.i492.i, i64* %ptr.i, align 8, !tbaa !2
  %309 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i491.i = add i64 %309, 1
  store i64 %add.i491.i, i64* %ptr.i, align 8, !tbaa !2
  br label %310

310:                                              ; preds = %313, %306
  %311 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i490.i = getelementptr inbounds i8, i8* %0, i64 %311
  %312 = load i8, i8* %arrayidx.i490.i, align 1, !tbaa !6
  %.not25.i = icmp eq i8 %312, 0
  br i1 %.not25.i, label %324, label %313

313:                                              ; preds = %310
  %314 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i489.i = add i64 %314, -1
  store i64 %add.i489.i, i64* %ptr.i, align 8, !tbaa !2
  %315 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i488.i = add i64 %315, -1
  store i64 %add.i488.i, i64* %ptr.i, align 8, !tbaa !2
  %316 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i487.i = add i64 %316, -1
  store i64 %add.i487.i, i64* %ptr.i, align 8, !tbaa !2
  %317 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i485.i = getelementptr inbounds i8, i8* %0, i64 %317
  %318 = load i8, i8* %arrayidx.i485.i, align 1, !tbaa !6
  %add.i486.i = add i8 %318, 1
  store i8 %add.i486.i, i8* %arrayidx.i485.i, align 1, !tbaa !6
  %319 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i484.i = add i64 %319, 1
  store i64 %add.i484.i, i64* %ptr.i, align 8, !tbaa !2
  %320 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i483.i = add i64 %320, 1
  store i64 %add.i483.i, i64* %ptr.i, align 8, !tbaa !2
  %321 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i482.i = add i64 %321, 1
  store i64 %add.i482.i, i64* %ptr.i, align 8, !tbaa !2
  %322 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i480.i = getelementptr inbounds i8, i8* %0, i64 %322
  %323 = load i8, i8* %arrayidx.i480.i, align 1, !tbaa !6
  %add.i481.i = add i8 %323, -1
  store i8 %add.i481.i, i8* %arrayidx.i480.i, align 1, !tbaa !6
  br label %310

324:                                              ; preds = %310
  %325 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i478.i = getelementptr inbounds i8, i8* %0, i64 %325
  %326 = load i8, i8* %arrayidx.i478.i, align 1, !tbaa !6
  %add.i479.i = add i8 %326, 1
  store i8 %add.i479.i, i8* %arrayidx.i478.i, align 1, !tbaa !6
  %327 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i477.i = add i64 %327, -1
  store i64 %add.i477.i, i64* %ptr.i, align 8, !tbaa !2
  br label %.loopexit32.i

.loopexit32.loopexit.i:                           ; preds = %342
  br label %.loopexit32.i

.loopexit32.i:                                    ; preds = %.loopexit32.loopexit.i, %324
  %328 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i476.i = getelementptr inbounds i8, i8* %0, i64 %328
  %329 = load i8, i8* %arrayidx.i476.i, align 1, !tbaa !6
  %.not26.i = icmp eq i8 %329, 0
  br i1 %.not26.i, label %332, label %330

330:                                              ; preds = %.loopexit32.i
  %331 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i475.i = add i64 %331, 1
  store i64 %add.i475.i, i64* %ptr.i, align 8, !tbaa !2
  br label %334

332:                                              ; preds = %.loopexit32.i
  %333 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i474.i = add i64 %333, 1
  store i64 %add.i474.i, i64* %ptr.i, align 8, !tbaa !2
  br label %.loopexit.i

334:                                              ; preds = %337, %330
  %335 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i473.i = getelementptr inbounds i8, i8* %0, i64 %335
  %336 = load i8, i8* %arrayidx.i473.i, align 1, !tbaa !6
  %.not30.i = icmp eq i8 %336, 0
  br i1 %.not30.i, label %340, label %337

337:                                              ; preds = %334
  %338 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i471.i = getelementptr inbounds i8, i8* %0, i64 %338
  %339 = load i8, i8* %arrayidx.i471.i, align 1, !tbaa !6
  %add.i472.i = add i8 %339, -1
  store i8 %add.i472.i, i8* %arrayidx.i471.i, align 1, !tbaa !6
  br label %334

340:                                              ; preds = %334
  %341 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i470.i = add i64 %341, -1
  store i64 %add.i470.i, i64* %ptr.i, align 8, !tbaa !2
  br label %342

342:                                              ; preds = %345, %340
  %343 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i469.i = getelementptr inbounds i8, i8* %0, i64 %343
  %344 = load i8, i8* %arrayidx.i469.i, align 1, !tbaa !6
  %.not31.i = icmp eq i8 %344, 0
  br i1 %.not31.i, label %.loopexit32.loopexit.i, label %345

345:                                              ; preds = %342
  %346 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i467.i = getelementptr inbounds i8, i8* %0, i64 %346
  %347 = load i8, i8* %arrayidx.i467.i, align 1, !tbaa !6
  %add.i468.i = add i8 %347, -1
  store i8 %add.i468.i, i8* %arrayidx.i467.i, align 1, !tbaa !6
  br label %342

.loopexit.loopexit.i:                             ; preds = %373
  br label %.loopexit.i

.loopexit.i:                                      ; preds = %.loopexit.loopexit.i, %332
  %348 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i466.i = getelementptr inbounds i8, i8* %0, i64 %348
  %349 = load i8, i8* %arrayidx.i466.i, align 1, !tbaa !6
  %.not27.i = icmp eq i8 %349, 0
  br i1 %.not27.i, label %353, label %350

350:                                              ; preds = %.loopexit.i
  %351 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i465.i = add i64 %351, -1
  store i64 %add.i465.i, i64* %ptr.i, align 8, !tbaa !2
  %352 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i464.i = add i64 %352, -1
  store i64 %add.i464.i, i64* %ptr.i, align 8, !tbaa !2
  br label %356

353:                                              ; preds = %.loopexit.i
  %354 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i463.i = add i64 %354, -1
  store i64 %add.i463.i, i64* %ptr.i, align 8, !tbaa !2
  %355 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i462.i = add i64 %355, -1
  store i64 %add.i462.i, i64* %ptr.i, align 8, !tbaa !2
  br label %280

356:                                              ; preds = %359, %350
  %357 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i461.i = getelementptr inbounds i8, i8* %0, i64 %357
  %358 = load i8, i8* %arrayidx.i461.i, align 1, !tbaa !6
  %.not28.i = icmp eq i8 %358, 0
  br i1 %.not28.i, label %370, label %359

359:                                              ; preds = %356
  %360 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i460.i = add i64 %360, 1
  store i64 %add.i460.i, i64* %ptr.i, align 8, !tbaa !2
  %361 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i459.i = add i64 %361, 1
  store i64 %add.i459.i, i64* %ptr.i, align 8, !tbaa !2
  %362 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i458.i = add i64 %362, 1
  store i64 %add.i458.i, i64* %ptr.i, align 8, !tbaa !2
  %363 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i456.i = getelementptr inbounds i8, i8* %0, i64 %363
  %364 = load i8, i8* %arrayidx.i456.i, align 1, !tbaa !6
  %add.i457.i = add i8 %364, 1
  store i8 %add.i457.i, i8* %arrayidx.i456.i, align 1, !tbaa !6
  %365 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i455.i = add i64 %365, -1
  store i64 %add.i455.i, i64* %ptr.i, align 8, !tbaa !2
  %366 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i454.i = add i64 %366, -1
  store i64 %add.i454.i, i64* %ptr.i, align 8, !tbaa !2
  %367 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i453.i = add i64 %367, -1
  store i64 %add.i453.i, i64* %ptr.i, align 8, !tbaa !2
  %368 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i451.i = getelementptr inbounds i8, i8* %0, i64 %368
  %369 = load i8, i8* %arrayidx.i451.i, align 1, !tbaa !6
  %add.i452.i = add i8 %369, -1
  store i8 %add.i452.i, i8* %arrayidx.i451.i, align 1, !tbaa !6
  br label %356

370:                                              ; preds = %356
  %371 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i450.i = add i64 %371, 1
  store i64 %add.i450.i, i64* %ptr.i, align 8, !tbaa !2
  %372 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i449.i = add i64 %372, 1
  store i64 %add.i449.i, i64* %ptr.i, align 8, !tbaa !2
  br label %373

373:                                              ; preds = %376, %370
  %374 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i448.i = getelementptr inbounds i8, i8* %0, i64 %374
  %375 = load i8, i8* %arrayidx.i448.i, align 1, !tbaa !6
  %.not29.i = icmp eq i8 %375, 0
  br i1 %.not29.i, label %.loopexit.loopexit.i, label %376

376:                                              ; preds = %373
  %377 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i446.i = getelementptr inbounds i8, i8* %0, i64 %377
  %378 = load i8, i8* %arrayidx.i446.i, align 1, !tbaa !6
  %add.i447.i = add i8 %378, -1
  store i8 %add.i447.i, i8* %arrayidx.i446.i, align 1, !tbaa !6
  br label %373

379:                                              ; preds = %382, %286
  %380 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i445.i = getelementptr inbounds i8, i8* %0, i64 %380
  %381 = load i8, i8* %arrayidx.i445.i, align 1, !tbaa !6
  %.not17.i = icmp eq i8 %381, 0
  br i1 %.not17.i, label %395, label %382

382:                                              ; preds = %379
  %383 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i444.i = add i64 %383, 1
  store i64 %add.i444.i, i64* %ptr.i, align 8, !tbaa !2
  %384 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i443.i = add i64 %384, 1
  store i64 %add.i443.i, i64* %ptr.i, align 8, !tbaa !2
  %385 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i441.i = getelementptr inbounds i8, i8* %0, i64 %385
  %386 = load i8, i8* %arrayidx.i441.i, align 1, !tbaa !6
  %add.i442.i = add i8 %386, 1
  store i8 %add.i442.i, i8* %arrayidx.i441.i, align 1, !tbaa !6
  %387 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i440.i = add i64 %387, 1
  store i64 %add.i440.i, i64* %ptr.i, align 8, !tbaa !2
  %388 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i438.i = getelementptr inbounds i8, i8* %0, i64 %388
  %389 = load i8, i8* %arrayidx.i438.i, align 1, !tbaa !6
  %add.i439.i = add i8 %389, 1
  store i8 %add.i439.i, i8* %arrayidx.i438.i, align 1, !tbaa !6
  %390 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i437.i = add i64 %390, -1
  store i64 %add.i437.i, i64* %ptr.i, align 8, !tbaa !2
  %391 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i436.i = add i64 %391, -1
  store i64 %add.i436.i, i64* %ptr.i, align 8, !tbaa !2
  %392 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i435.i = add i64 %392, -1
  store i64 %add.i435.i, i64* %ptr.i, align 8, !tbaa !2
  %393 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i433.i = getelementptr inbounds i8, i8* %0, i64 %393
  %394 = load i8, i8* %arrayidx.i433.i, align 1, !tbaa !6
  %add.i434.i = add i8 %394, -1
  store i8 %add.i434.i, i8* %arrayidx.i433.i, align 1, !tbaa !6
  br label %379

395:                                              ; preds = %379
  %396 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i432.i = add i64 %396, 1
  store i64 %add.i432.i, i64* %ptr.i, align 8, !tbaa !2
  %397 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i431.i = add i64 %397, 1
  store i64 %add.i431.i, i64* %ptr.i, align 8, !tbaa !2
  %398 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i430.i = add i64 %398, 1
  store i64 %add.i430.i, i64* %ptr.i, align 8, !tbaa !2
  br label %399

399:                                              ; preds = %402, %395
  %400 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i429.i = getelementptr inbounds i8, i8* %0, i64 %400
  %401 = load i8, i8* %arrayidx.i429.i, align 1, !tbaa !6
  %.not18.i = icmp eq i8 %401, 0
  br i1 %.not18.i, label %413, label %402

402:                                              ; preds = %399
  %403 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i428.i = add i64 %403, -1
  store i64 %add.i428.i, i64* %ptr.i, align 8, !tbaa !2
  %404 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i427.i = add i64 %404, -1
  store i64 %add.i427.i, i64* %ptr.i, align 8, !tbaa !2
  %405 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i426.i = add i64 %405, -1
  store i64 %add.i426.i, i64* %ptr.i, align 8, !tbaa !2
  %406 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i424.i = getelementptr inbounds i8, i8* %0, i64 %406
  %407 = load i8, i8* %arrayidx.i424.i, align 1, !tbaa !6
  %add.i425.i = add i8 %407, 1
  store i8 %add.i425.i, i8* %arrayidx.i424.i, align 1, !tbaa !6
  %408 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i423.i = add i64 %408, 1
  store i64 %add.i423.i, i64* %ptr.i, align 8, !tbaa !2
  %409 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i422.i = add i64 %409, 1
  store i64 %add.i422.i, i64* %ptr.i, align 8, !tbaa !2
  %410 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i421.i = add i64 %410, 1
  store i64 %add.i421.i, i64* %ptr.i, align 8, !tbaa !2
  %411 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i419.i = getelementptr inbounds i8, i8* %0, i64 %411
  %412 = load i8, i8* %arrayidx.i419.i, align 1, !tbaa !6
  %add.i420.i = add i8 %412, -1
  store i8 %add.i420.i, i8* %arrayidx.i419.i, align 1, !tbaa !6
  br label %399

413:                                              ; preds = %399
  %414 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i417.i = getelementptr inbounds i8, i8* %0, i64 %414
  %415 = load i8, i8* %arrayidx.i417.i, align 1, !tbaa !6
  %add.i418.i = add i8 %415, 1
  store i8 %add.i418.i, i8* %arrayidx.i417.i, align 1, !tbaa !6
  %416 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i416.i = add i64 %416, -1
  store i64 %add.i416.i, i64* %ptr.i, align 8, !tbaa !2
  br label %.loopexit34.i

.loopexit34.loopexit.i:                           ; preds = %431
  br label %.loopexit34.i

.loopexit34.i:                                    ; preds = %.loopexit34.loopexit.i, %413
  %417 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i415.i = getelementptr inbounds i8, i8* %0, i64 %417
  %418 = load i8, i8* %arrayidx.i415.i, align 1, !tbaa !6
  %.not19.i = icmp eq i8 %418, 0
  br i1 %.not19.i, label %421, label %419

419:                                              ; preds = %.loopexit34.i
  %420 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i414.i = add i64 %420, 1
  store i64 %add.i414.i, i64* %ptr.i, align 8, !tbaa !2
  br label %423

421:                                              ; preds = %.loopexit34.i
  %422 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i413.i = add i64 %422, 1
  store i64 %add.i413.i, i64* %ptr.i, align 8, !tbaa !2
  br label %.loopexit33.i

423:                                              ; preds = %426, %419
  %424 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i412.i = getelementptr inbounds i8, i8* %0, i64 %424
  %425 = load i8, i8* %arrayidx.i412.i, align 1, !tbaa !6
  %.not22.i = icmp eq i8 %425, 0
  br i1 %.not22.i, label %429, label %426

426:                                              ; preds = %423
  %427 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i410.i = getelementptr inbounds i8, i8* %0, i64 %427
  %428 = load i8, i8* %arrayidx.i410.i, align 1, !tbaa !6
  %add.i411.i = add i8 %428, -1
  store i8 %add.i411.i, i8* %arrayidx.i410.i, align 1, !tbaa !6
  br label %423

429:                                              ; preds = %423
  %430 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i409.i = add i64 %430, -1
  store i64 %add.i409.i, i64* %ptr.i, align 8, !tbaa !2
  br label %431

431:                                              ; preds = %434, %429
  %432 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i408.i = getelementptr inbounds i8, i8* %0, i64 %432
  %433 = load i8, i8* %arrayidx.i408.i, align 1, !tbaa !6
  %.not23.i = icmp eq i8 %433, 0
  br i1 %.not23.i, label %.loopexit34.loopexit.i, label %434

434:                                              ; preds = %431
  %435 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i406.i = getelementptr inbounds i8, i8* %0, i64 %435
  %436 = load i8, i8* %arrayidx.i406.i, align 1, !tbaa !6
  %add.i407.i = add i8 %436, -1
  store i8 %add.i407.i, i8* %arrayidx.i406.i, align 1, !tbaa !6
  br label %431

.loopexit33.loopexit.i:                           ; preds = %453
  br label %.loopexit33.i

.loopexit33.i:                                    ; preds = %.loopexit33.loopexit.i, %421
  %437 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i405.i = getelementptr inbounds i8, i8* %0, i64 %437
  %438 = load i8, i8* %arrayidx.i405.i, align 1, !tbaa !6
  %.not20.i = icmp eq i8 %438, 0
  br i1 %.not20.i, label %446, label %439

439:                                              ; preds = %.loopexit33.i
  %440 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i404.i = add i64 %440, -1
  store i64 %add.i404.i, i64* %ptr.i, align 8, !tbaa !2
  %441 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i403.i = add i64 %441, -1
  store i64 %add.i403.i, i64* %ptr.i, align 8, !tbaa !2
  %442 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i401.i = getelementptr inbounds i8, i8* %0, i64 %442
  %443 = load i8, i8* %arrayidx.i401.i, align 1, !tbaa !6
  %add.i402.i = add i8 %443, 1
  store i8 %add.i402.i, i8* %arrayidx.i401.i, align 1, !tbaa !6
  %444 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i400.i = add i64 %444, 1
  store i64 %add.i400.i, i64* %ptr.i, align 8, !tbaa !2
  %445 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i399.i = add i64 %445, 1
  store i64 %add.i399.i, i64* %ptr.i, align 8, !tbaa !2
  br label %453

446:                                              ; preds = %.loopexit33.i
  %447 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i398.i = add i64 %447, -1
  store i64 %add.i398.i, i64* %ptr.i, align 8, !tbaa !2
  %448 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i397.i = add i64 %448, -1
  store i64 %add.i397.i, i64* %ptr.i, align 8, !tbaa !2
  %449 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i396.i = add i64 %449, -1
  store i64 %add.i396.i, i64* %ptr.i, align 8, !tbaa !2
  %450 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i395.i = add i64 %450, -1
  store i64 %add.i395.i, i64* %ptr.i, align 8, !tbaa !2
  %451 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i394.i = add i64 %451, -1
  store i64 %add.i394.i, i64* %ptr.i, align 8, !tbaa !2
  %452 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i393.i = add i64 %452, -1
  store i64 %add.i393.i, i64* %ptr.i, align 8, !tbaa !2
  br label %.preheader.i

453:                                              ; preds = %456, %439
  %454 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i392.i = getelementptr inbounds i8, i8* %0, i64 %454
  %455 = load i8, i8* %arrayidx.i392.i, align 1, !tbaa !6
  %.not21.i = icmp eq i8 %455, 0
  br i1 %.not21.i, label %.loopexit33.loopexit.i, label %456

456:                                              ; preds = %453
  %457 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i390.i = getelementptr inbounds i8, i8* %0, i64 %457
  %458 = load i8, i8* %arrayidx.i390.i, align 1, !tbaa !6
  %add.i391.i = add i8 %458, -1
  store i8 %add.i391.i, i8* %arrayidx.i390.i, align 1, !tbaa !6
  br label %453

.loopexit36.loopexit.i:                           ; preds = %582
  br label %.loopexit36.i

.loopexit36.i:                                    ; preds = %.loopexit36.loopexit.i, %274
  %459 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i389.i = getelementptr inbounds i8, i8* %0, i64 %459
  %460 = load i8, i8* %arrayidx.i389.i, align 1, !tbaa !6
  %.not4.i = icmp eq i8 %460, 0
  br i1 %.not4.i, label %561, label %461

461:                                              ; preds = %.loopexit36.i
  %462 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i387.i = getelementptr inbounds i8, i8* %0, i64 %462
  %463 = load i8, i8* %arrayidx.i387.i, align 1, !tbaa !6
  %add.i388.i = add i8 %463, 1
  store i8 %add.i388.i, i8* %arrayidx.i387.i, align 1, !tbaa !6
  %464 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i385.i = getelementptr inbounds i8, i8* %0, i64 %464
  %465 = load i8, i8* %arrayidx.i385.i, align 1, !tbaa !6
  %add.i386.i = add i8 %465, 1
  store i8 %add.i386.i, i8* %arrayidx.i385.i, align 1, !tbaa !6
  %466 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i383.i = getelementptr inbounds i8, i8* %0, i64 %466
  %467 = load i8, i8* %arrayidx.i383.i, align 1, !tbaa !6
  %add.i384.i = add i8 %467, 1
  store i8 %add.i384.i, i8* %arrayidx.i383.i, align 1, !tbaa !6
  %468 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i381.i = getelementptr inbounds i8, i8* %0, i64 %468
  %469 = load i8, i8* %arrayidx.i381.i, align 1, !tbaa !6
  %add.i382.i = add i8 %469, 1
  store i8 %add.i382.i, i8* %arrayidx.i381.i, align 1, !tbaa !6
  %470 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i379.i = getelementptr inbounds i8, i8* %0, i64 %470
  %471 = load i8, i8* %arrayidx.i379.i, align 1, !tbaa !6
  %add.i380.i = add i8 %471, 1
  store i8 %add.i380.i, i8* %arrayidx.i379.i, align 1, !tbaa !6
  %472 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i377.i = getelementptr inbounds i8, i8* %0, i64 %472
  %473 = load i8, i8* %arrayidx.i377.i, align 1, !tbaa !6
  %add.i378.i = add i8 %473, 1
  store i8 %add.i378.i, i8* %arrayidx.i377.i, align 1, !tbaa !6
  %474 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i375.i = getelementptr inbounds i8, i8* %0, i64 %474
  %475 = load i8, i8* %arrayidx.i375.i, align 1, !tbaa !6
  %add.i376.i = add i8 %475, 1
  store i8 %add.i376.i, i8* %arrayidx.i375.i, align 1, !tbaa !6
  %476 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i373.i = getelementptr inbounds i8, i8* %0, i64 %476
  %477 = load i8, i8* %arrayidx.i373.i, align 1, !tbaa !6
  %add.i374.i = add i8 %477, 1
  store i8 %add.i374.i, i8* %arrayidx.i373.i, align 1, !tbaa !6
  %478 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i371.i = getelementptr inbounds i8, i8* %0, i64 %478
  %479 = load i8, i8* %arrayidx.i371.i, align 1, !tbaa !6
  %add.i372.i = add i8 %479, 1
  store i8 %add.i372.i, i8* %arrayidx.i371.i, align 1, !tbaa !6
  %480 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i369.i = getelementptr inbounds i8, i8* %0, i64 %480
  %481 = load i8, i8* %arrayidx.i369.i, align 1, !tbaa !6
  %add.i370.i = add i8 %481, 1
  store i8 %add.i370.i, i8* %arrayidx.i369.i, align 1, !tbaa !6
  %482 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i367.i = getelementptr inbounds i8, i8* %0, i64 %482
  %483 = load i8, i8* %arrayidx.i367.i, align 1, !tbaa !6
  %add.i368.i = add i8 %483, 1
  store i8 %add.i368.i, i8* %arrayidx.i367.i, align 1, !tbaa !6
  %484 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i365.i = getelementptr inbounds i8, i8* %0, i64 %484
  %485 = load i8, i8* %arrayidx.i365.i, align 1, !tbaa !6
  %add.i366.i = add i8 %485, 1
  store i8 %add.i366.i, i8* %arrayidx.i365.i, align 1, !tbaa !6
  %486 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i363.i = getelementptr inbounds i8, i8* %0, i64 %486
  %487 = load i8, i8* %arrayidx.i363.i, align 1, !tbaa !6
  %add.i364.i = add i8 %487, 1
  store i8 %add.i364.i, i8* %arrayidx.i363.i, align 1, !tbaa !6
  %488 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i361.i = getelementptr inbounds i8, i8* %0, i64 %488
  %489 = load i8, i8* %arrayidx.i361.i, align 1, !tbaa !6
  %add.i362.i = add i8 %489, 1
  store i8 %add.i362.i, i8* %arrayidx.i361.i, align 1, !tbaa !6
  %490 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i359.i = getelementptr inbounds i8, i8* %0, i64 %490
  %491 = load i8, i8* %arrayidx.i359.i, align 1, !tbaa !6
  %add.i360.i = add i8 %491, 1
  store i8 %add.i360.i, i8* %arrayidx.i359.i, align 1, !tbaa !6
  %492 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i357.i = getelementptr inbounds i8, i8* %0, i64 %492
  %493 = load i8, i8* %arrayidx.i357.i, align 1, !tbaa !6
  %add.i358.i = add i8 %493, 1
  store i8 %add.i358.i, i8* %arrayidx.i357.i, align 1, !tbaa !6
  %494 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i355.i = getelementptr inbounds i8, i8* %0, i64 %494
  %495 = load i8, i8* %arrayidx.i355.i, align 1, !tbaa !6
  %add.i356.i = add i8 %495, 1
  store i8 %add.i356.i, i8* %arrayidx.i355.i, align 1, !tbaa !6
  %496 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i353.i = getelementptr inbounds i8, i8* %0, i64 %496
  %497 = load i8, i8* %arrayidx.i353.i, align 1, !tbaa !6
  %add.i354.i = add i8 %497, 1
  store i8 %add.i354.i, i8* %arrayidx.i353.i, align 1, !tbaa !6
  %498 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i351.i = getelementptr inbounds i8, i8* %0, i64 %498
  %499 = load i8, i8* %arrayidx.i351.i, align 1, !tbaa !6
  %add.i352.i = add i8 %499, 1
  store i8 %add.i352.i, i8* %arrayidx.i351.i, align 1, !tbaa !6
  %500 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i349.i = getelementptr inbounds i8, i8* %0, i64 %500
  %501 = load i8, i8* %arrayidx.i349.i, align 1, !tbaa !6
  %add.i350.i = add i8 %501, 1
  store i8 %add.i350.i, i8* %arrayidx.i349.i, align 1, !tbaa !6
  %502 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i347.i = getelementptr inbounds i8, i8* %0, i64 %502
  %503 = load i8, i8* %arrayidx.i347.i, align 1, !tbaa !6
  %add.i348.i = add i8 %503, 1
  store i8 %add.i348.i, i8* %arrayidx.i347.i, align 1, !tbaa !6
  %504 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i345.i = getelementptr inbounds i8, i8* %0, i64 %504
  %505 = load i8, i8* %arrayidx.i345.i, align 1, !tbaa !6
  %add.i346.i = add i8 %505, 1
  store i8 %add.i346.i, i8* %arrayidx.i345.i, align 1, !tbaa !6
  %506 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i343.i = getelementptr inbounds i8, i8* %0, i64 %506
  %507 = load i8, i8* %arrayidx.i343.i, align 1, !tbaa !6
  %add.i344.i = add i8 %507, 1
  store i8 %add.i344.i, i8* %arrayidx.i343.i, align 1, !tbaa !6
  %508 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i341.i = getelementptr inbounds i8, i8* %0, i64 %508
  %509 = load i8, i8* %arrayidx.i341.i, align 1, !tbaa !6
  %add.i342.i = add i8 %509, 1
  store i8 %add.i342.i, i8* %arrayidx.i341.i, align 1, !tbaa !6
  %510 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i339.i = getelementptr inbounds i8, i8* %0, i64 %510
  %511 = load i8, i8* %arrayidx.i339.i, align 1, !tbaa !6
  %add.i340.i = add i8 %511, 1
  store i8 %add.i340.i, i8* %arrayidx.i339.i, align 1, !tbaa !6
  %512 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i337.i = getelementptr inbounds i8, i8* %0, i64 %512
  %513 = load i8, i8* %arrayidx.i337.i, align 1, !tbaa !6
  %add.i338.i = add i8 %513, 1
  store i8 %add.i338.i, i8* %arrayidx.i337.i, align 1, !tbaa !6
  %514 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i335.i = getelementptr inbounds i8, i8* %0, i64 %514
  %515 = load i8, i8* %arrayidx.i335.i, align 1, !tbaa !6
  %add.i336.i = add i8 %515, 1
  store i8 %add.i336.i, i8* %arrayidx.i335.i, align 1, !tbaa !6
  %516 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i333.i = getelementptr inbounds i8, i8* %0, i64 %516
  %517 = load i8, i8* %arrayidx.i333.i, align 1, !tbaa !6
  %add.i334.i = add i8 %517, 1
  store i8 %add.i334.i, i8* %arrayidx.i333.i, align 1, !tbaa !6
  %518 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i331.i = getelementptr inbounds i8, i8* %0, i64 %518
  %519 = load i8, i8* %arrayidx.i331.i, align 1, !tbaa !6
  %add.i332.i = add i8 %519, 1
  store i8 %add.i332.i, i8* %arrayidx.i331.i, align 1, !tbaa !6
  %520 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i329.i = getelementptr inbounds i8, i8* %0, i64 %520
  %521 = load i8, i8* %arrayidx.i329.i, align 1, !tbaa !6
  %add.i330.i = add i8 %521, 1
  store i8 %add.i330.i, i8* %arrayidx.i329.i, align 1, !tbaa !6
  %522 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i327.i = getelementptr inbounds i8, i8* %0, i64 %522
  %523 = load i8, i8* %arrayidx.i327.i, align 1, !tbaa !6
  %add.i328.i = add i8 %523, 1
  store i8 %add.i328.i, i8* %arrayidx.i327.i, align 1, !tbaa !6
  %524 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i325.i = getelementptr inbounds i8, i8* %0, i64 %524
  %525 = load i8, i8* %arrayidx.i325.i, align 1, !tbaa !6
  %add.i326.i = add i8 %525, 1
  store i8 %add.i326.i, i8* %arrayidx.i325.i, align 1, !tbaa !6
  %526 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i323.i = getelementptr inbounds i8, i8* %0, i64 %526
  %527 = load i8, i8* %arrayidx.i323.i, align 1, !tbaa !6
  %add.i324.i = add i8 %527, 1
  store i8 %add.i324.i, i8* %arrayidx.i323.i, align 1, !tbaa !6
  %528 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i321.i = getelementptr inbounds i8, i8* %0, i64 %528
  %529 = load i8, i8* %arrayidx.i321.i, align 1, !tbaa !6
  %add.i322.i = add i8 %529, 1
  store i8 %add.i322.i, i8* %arrayidx.i321.i, align 1, !tbaa !6
  %530 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i319.i = getelementptr inbounds i8, i8* %0, i64 %530
  %531 = load i8, i8* %arrayidx.i319.i, align 1, !tbaa !6
  %add.i320.i = add i8 %531, 1
  store i8 %add.i320.i, i8* %arrayidx.i319.i, align 1, !tbaa !6
  %532 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i317.i = getelementptr inbounds i8, i8* %0, i64 %532
  %533 = load i8, i8* %arrayidx.i317.i, align 1, !tbaa !6
  %add.i318.i = add i8 %533, 1
  store i8 %add.i318.i, i8* %arrayidx.i317.i, align 1, !tbaa !6
  %534 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i315.i = getelementptr inbounds i8, i8* %0, i64 %534
  %535 = load i8, i8* %arrayidx.i315.i, align 1, !tbaa !6
  %add.i316.i = add i8 %535, 1
  store i8 %add.i316.i, i8* %arrayidx.i315.i, align 1, !tbaa !6
  %536 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i313.i = getelementptr inbounds i8, i8* %0, i64 %536
  %537 = load i8, i8* %arrayidx.i313.i, align 1, !tbaa !6
  %add.i314.i = add i8 %537, 1
  store i8 %add.i314.i, i8* %arrayidx.i313.i, align 1, !tbaa !6
  %538 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i311.i = getelementptr inbounds i8, i8* %0, i64 %538
  %539 = load i8, i8* %arrayidx.i311.i, align 1, !tbaa !6
  %add.i312.i = add i8 %539, 1
  store i8 %add.i312.i, i8* %arrayidx.i311.i, align 1, !tbaa !6
  %540 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i309.i = getelementptr inbounds i8, i8* %0, i64 %540
  %541 = load i8, i8* %arrayidx.i309.i, align 1, !tbaa !6
  %add.i310.i = add i8 %541, 1
  store i8 %add.i310.i, i8* %arrayidx.i309.i, align 1, !tbaa !6
  %542 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i307.i = getelementptr inbounds i8, i8* %0, i64 %542
  %543 = load i8, i8* %arrayidx.i307.i, align 1, !tbaa !6
  %add.i308.i = add i8 %543, 1
  store i8 %add.i308.i, i8* %arrayidx.i307.i, align 1, !tbaa !6
  %544 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i305.i = getelementptr inbounds i8, i8* %0, i64 %544
  %545 = load i8, i8* %arrayidx.i305.i, align 1, !tbaa !6
  %add.i306.i = add i8 %545, 1
  store i8 %add.i306.i, i8* %arrayidx.i305.i, align 1, !tbaa !6
  %546 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i303.i = getelementptr inbounds i8, i8* %0, i64 %546
  %547 = load i8, i8* %arrayidx.i303.i, align 1, !tbaa !6
  %add.i304.i = add i8 %547, 1
  store i8 %add.i304.i, i8* %arrayidx.i303.i, align 1, !tbaa !6
  %548 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i301.i = getelementptr inbounds i8, i8* %0, i64 %548
  %549 = load i8, i8* %arrayidx.i301.i, align 1, !tbaa !6
  %add.i302.i = add i8 %549, 1
  store i8 %add.i302.i, i8* %arrayidx.i301.i, align 1, !tbaa !6
  %550 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i299.i = getelementptr inbounds i8, i8* %0, i64 %550
  %551 = load i8, i8* %arrayidx.i299.i, align 1, !tbaa !6
  %add.i300.i = add i8 %551, 1
  store i8 %add.i300.i, i8* %arrayidx.i299.i, align 1, !tbaa !6
  %552 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i297.i = getelementptr inbounds i8, i8* %0, i64 %552
  %553 = load i8, i8* %arrayidx.i297.i, align 1, !tbaa !6
  %add.i298.i = add i8 %553, 1
  store i8 %add.i298.i, i8* %arrayidx.i297.i, align 1, !tbaa !6
  %554 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i295.i = getelementptr inbounds i8, i8* %0, i64 %554
  %555 = load i8, i8* %arrayidx.i295.i, align 1, !tbaa !6
  %add.i296.i = add i8 %555, 1
  store i8 %add.i296.i, i8* %arrayidx.i295.i, align 1, !tbaa !6
  %556 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i293.i = getelementptr inbounds i8, i8* %0, i64 %556
  %557 = load i8, i8* %arrayidx.i293.i, align 1, !tbaa !6
  %add.i294.i = add i8 %557, 1
  store i8 %add.i294.i, i8* %arrayidx.i293.i, align 1, !tbaa !6
  %558 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i288.i = getelementptr inbounds i8, i8* %0, i64 %558
  %559 = load i8, i8* %arrayidx.i288.i, align 1, !tbaa !6
  %conv.i289.i = zext i8 %559 to i32
  %560 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i290.i = call i32 @putc(i32 %conv.i289.i, %struct._IO_FILE* %560) #9
  br label %582

561:                                              ; preds = %.loopexit36.i
  %562 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i286.i = getelementptr inbounds i8, i8* %0, i64 %562
  %563 = load i8, i8* %arrayidx.i286.i, align 1, !tbaa !6
  %add.i287.i = add i8 %563, 1
  store i8 %add.i287.i, i8* %arrayidx.i286.i, align 1, !tbaa !6
  %564 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i284.i = getelementptr inbounds i8, i8* %0, i64 %564
  %565 = load i8, i8* %arrayidx.i284.i, align 1, !tbaa !6
  %add.i285.i = add i8 %565, 1
  store i8 %add.i285.i, i8* %arrayidx.i284.i, align 1, !tbaa !6
  %566 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i282.i = getelementptr inbounds i8, i8* %0, i64 %566
  %567 = load i8, i8* %arrayidx.i282.i, align 1, !tbaa !6
  %add.i283.i = add i8 %567, 1
  store i8 %add.i283.i, i8* %arrayidx.i282.i, align 1, !tbaa !6
  %568 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i280.i = getelementptr inbounds i8, i8* %0, i64 %568
  %569 = load i8, i8* %arrayidx.i280.i, align 1, !tbaa !6
  %add.i281.i = add i8 %569, 1
  store i8 %add.i281.i, i8* %arrayidx.i280.i, align 1, !tbaa !6
  %570 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i278.i = getelementptr inbounds i8, i8* %0, i64 %570
  %571 = load i8, i8* %arrayidx.i278.i, align 1, !tbaa !6
  %add.i279.i = add i8 %571, 1
  store i8 %add.i279.i, i8* %arrayidx.i278.i, align 1, !tbaa !6
  %572 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i276.i = getelementptr inbounds i8, i8* %0, i64 %572
  %573 = load i8, i8* %arrayidx.i276.i, align 1, !tbaa !6
  %add.i277.i = add i8 %573, 1
  store i8 %add.i277.i, i8* %arrayidx.i276.i, align 1, !tbaa !6
  %574 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i274.i = getelementptr inbounds i8, i8* %0, i64 %574
  %575 = load i8, i8* %arrayidx.i274.i, align 1, !tbaa !6
  %add.i275.i = add i8 %575, 1
  store i8 %add.i275.i, i8* %arrayidx.i274.i, align 1, !tbaa !6
  %576 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i272.i = getelementptr inbounds i8, i8* %0, i64 %576
  %577 = load i8, i8* %arrayidx.i272.i, align 1, !tbaa !6
  %add.i273.i = add i8 %577, 1
  store i8 %add.i273.i, i8* %arrayidx.i272.i, align 1, !tbaa !6
  %578 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i270.i = getelementptr inbounds i8, i8* %0, i64 %578
  %579 = load i8, i8* %arrayidx.i270.i, align 1, !tbaa !6
  %add.i271.i = add i8 %579, 1
  store i8 %add.i271.i, i8* %arrayidx.i270.i, align 1, !tbaa !6
  %580 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i268.i = getelementptr inbounds i8, i8* %0, i64 %580
  %581 = load i8, i8* %arrayidx.i268.i, align 1, !tbaa !6
  %add.i269.i = add i8 %581, 1
  store i8 %add.i269.i, i8* %arrayidx.i268.i, align 1, !tbaa !6
  br label %588

582:                                              ; preds = %585, %461
  %583 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i267.i = getelementptr inbounds i8, i8* %0, i64 %583
  %584 = load i8, i8* %arrayidx.i267.i, align 1, !tbaa !6
  %.not15.i = icmp eq i8 %584, 0
  br i1 %.not15.i, label %.loopexit36.loopexit.i, label %585

585:                                              ; preds = %582
  %586 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i265.i = getelementptr inbounds i8, i8* %0, i64 %586
  %587 = load i8, i8* %arrayidx.i265.i, align 1, !tbaa !6
  %add.i266.i = add i8 %587, -1
  store i8 %add.i266.i, i8* %arrayidx.i265.i, align 1, !tbaa !6
  br label %582

588:                                              ; preds = %592, %561
  %589 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i264.i = add i64 %589, -1
  store i64 %add.i264.i, i64* %ptr.i, align 8, !tbaa !2
  %590 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i263.i = getelementptr inbounds i8, i8* %0, i64 %590
  %591 = load i8, i8* %arrayidx.i263.i, align 1, !tbaa !6
  %.not5.i = icmp eq i8 %591, 0
  br i1 %.not5.i, label %598, label %592

592:                                              ; preds = %588
  %593 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i261.i = getelementptr inbounds i8, i8* %0, i64 %593
  %594 = load i8, i8* %arrayidx.i261.i, align 1, !tbaa !6
  %add.i262.i = add i8 %594, -1
  store i8 %add.i262.i, i8* %arrayidx.i261.i, align 1, !tbaa !6
  %595 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i260.i = add i64 %595, 1
  store i64 %add.i260.i, i64* %ptr.i, align 8, !tbaa !2
  %596 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i258.i = getelementptr inbounds i8, i8* %0, i64 %596
  %597 = load i8, i8* %arrayidx.i258.i, align 1, !tbaa !6
  %add.i259.i = add i8 %597, -1
  store i8 %add.i259.i, i8* %arrayidx.i258.i, align 1, !tbaa !6
  br label %588

598:                                              ; preds = %588
  %599 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i257.i = add i64 %599, 1
  store i64 %add.i257.i, i64* %ptr.i, align 8, !tbaa !2
  %600 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i255.i = getelementptr inbounds i8, i8* %0, i64 %600
  %601 = load i8, i8* %arrayidx.i255.i, align 1, !tbaa !6
  %add.i256.i = add i8 %601, 1
  store i8 %add.i256.i, i8* %arrayidx.i255.i, align 1, !tbaa !6
  %602 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i253.i = getelementptr inbounds i8, i8* %0, i64 %602
  %603 = load i8, i8* %arrayidx.i253.i, align 1, !tbaa !6
  %add.i254.i = add i8 %603, 1
  store i8 %add.i254.i, i8* %arrayidx.i253.i, align 1, !tbaa !6
  %604 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i251.i = getelementptr inbounds i8, i8* %0, i64 %604
  %605 = load i8, i8* %arrayidx.i251.i, align 1, !tbaa !6
  %add.i252.i = add i8 %605, 1
  store i8 %add.i252.i, i8* %arrayidx.i251.i, align 1, !tbaa !6
  %606 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i249.i = getelementptr inbounds i8, i8* %0, i64 %606
  %607 = load i8, i8* %arrayidx.i249.i, align 1, !tbaa !6
  %add.i250.i = add i8 %607, 1
  store i8 %add.i250.i, i8* %arrayidx.i249.i, align 1, !tbaa !6
  %608 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i247.i = getelementptr inbounds i8, i8* %0, i64 %608
  %609 = load i8, i8* %arrayidx.i247.i, align 1, !tbaa !6
  %add.i248.i = add i8 %609, 1
  store i8 %add.i248.i, i8* %arrayidx.i247.i, align 1, !tbaa !6
  %610 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i245.i = getelementptr inbounds i8, i8* %0, i64 %610
  %611 = load i8, i8* %arrayidx.i245.i, align 1, !tbaa !6
  %add.i246.i = add i8 %611, 1
  store i8 %add.i246.i, i8* %arrayidx.i245.i, align 1, !tbaa !6
  %612 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i243.i = getelementptr inbounds i8, i8* %0, i64 %612
  %613 = load i8, i8* %arrayidx.i243.i, align 1, !tbaa !6
  %add.i244.i = add i8 %613, 1
  store i8 %add.i244.i, i8* %arrayidx.i243.i, align 1, !tbaa !6
  %614 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i241.i = getelementptr inbounds i8, i8* %0, i64 %614
  %615 = load i8, i8* %arrayidx.i241.i, align 1, !tbaa !6
  %add.i242.i = add i8 %615, 1
  store i8 %add.i242.i, i8* %arrayidx.i241.i, align 1, !tbaa !6
  %616 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i239.i = getelementptr inbounds i8, i8* %0, i64 %616
  %617 = load i8, i8* %arrayidx.i239.i, align 1, !tbaa !6
  %add.i240.i = add i8 %617, 1
  store i8 %add.i240.i, i8* %arrayidx.i239.i, align 1, !tbaa !6
  %618 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i237.i = getelementptr inbounds i8, i8* %0, i64 %618
  %619 = load i8, i8* %arrayidx.i237.i, align 1, !tbaa !6
  %add.i238.i = add i8 %619, 1
  store i8 %add.i238.i, i8* %arrayidx.i237.i, align 1, !tbaa !6
  %620 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i235.i = getelementptr inbounds i8, i8* %0, i64 %620
  %621 = load i8, i8* %arrayidx.i235.i, align 1, !tbaa !6
  %add.i236.i = add i8 %621, 1
  store i8 %add.i236.i, i8* %arrayidx.i235.i, align 1, !tbaa !6
  %622 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i233.i = getelementptr inbounds i8, i8* %0, i64 %622
  %623 = load i8, i8* %arrayidx.i233.i, align 1, !tbaa !6
  %add.i234.i = add i8 %623, 1
  store i8 %add.i234.i, i8* %arrayidx.i233.i, align 1, !tbaa !6
  %624 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i231.i = getelementptr inbounds i8, i8* %0, i64 %624
  %625 = load i8, i8* %arrayidx.i231.i, align 1, !tbaa !6
  %add.i232.i = add i8 %625, 1
  store i8 %add.i232.i, i8* %arrayidx.i231.i, align 1, !tbaa !6
  %626 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i229.i = getelementptr inbounds i8, i8* %0, i64 %626
  %627 = load i8, i8* %arrayidx.i229.i, align 1, !tbaa !6
  %add.i230.i = add i8 %627, 1
  store i8 %add.i230.i, i8* %arrayidx.i229.i, align 1, !tbaa !6
  %628 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i227.i = getelementptr inbounds i8, i8* %0, i64 %628
  %629 = load i8, i8* %arrayidx.i227.i, align 1, !tbaa !6
  %add.i228.i = add i8 %629, 1
  store i8 %add.i228.i, i8* %arrayidx.i227.i, align 1, !tbaa !6
  %630 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i225.i = getelementptr inbounds i8, i8* %0, i64 %630
  %631 = load i8, i8* %arrayidx.i225.i, align 1, !tbaa !6
  %add.i226.i = add i8 %631, 1
  store i8 %add.i226.i, i8* %arrayidx.i225.i, align 1, !tbaa !6
  %632 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i223.i = getelementptr inbounds i8, i8* %0, i64 %632
  %633 = load i8, i8* %arrayidx.i223.i, align 1, !tbaa !6
  %add.i224.i = add i8 %633, 1
  store i8 %add.i224.i, i8* %arrayidx.i223.i, align 1, !tbaa !6
  %634 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i221.i = getelementptr inbounds i8, i8* %0, i64 %634
  %635 = load i8, i8* %arrayidx.i221.i, align 1, !tbaa !6
  %add.i222.i = add i8 %635, 1
  store i8 %add.i222.i, i8* %arrayidx.i221.i, align 1, !tbaa !6
  %636 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i219.i = getelementptr inbounds i8, i8* %0, i64 %636
  %637 = load i8, i8* %arrayidx.i219.i, align 1, !tbaa !6
  %add.i220.i = add i8 %637, 1
  store i8 %add.i220.i, i8* %arrayidx.i219.i, align 1, !tbaa !6
  %638 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i217.i = getelementptr inbounds i8, i8* %0, i64 %638
  %639 = load i8, i8* %arrayidx.i217.i, align 1, !tbaa !6
  %add.i218.i = add i8 %639, 1
  store i8 %add.i218.i, i8* %arrayidx.i217.i, align 1, !tbaa !6
  %640 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i215.i = getelementptr inbounds i8, i8* %0, i64 %640
  %641 = load i8, i8* %arrayidx.i215.i, align 1, !tbaa !6
  %add.i216.i = add i8 %641, 1
  store i8 %add.i216.i, i8* %arrayidx.i215.i, align 1, !tbaa !6
  %642 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i213.i = getelementptr inbounds i8, i8* %0, i64 %642
  %643 = load i8, i8* %arrayidx.i213.i, align 1, !tbaa !6
  %add.i214.i = add i8 %643, 1
  store i8 %add.i214.i, i8* %arrayidx.i213.i, align 1, !tbaa !6
  %644 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i211.i = getelementptr inbounds i8, i8* %0, i64 %644
  %645 = load i8, i8* %arrayidx.i211.i, align 1, !tbaa !6
  %add.i212.i = add i8 %645, 1
  store i8 %add.i212.i, i8* %arrayidx.i211.i, align 1, !tbaa !6
  %646 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i209.i = getelementptr inbounds i8, i8* %0, i64 %646
  %647 = load i8, i8* %arrayidx.i209.i, align 1, !tbaa !6
  %add.i210.i = add i8 %647, 1
  store i8 %add.i210.i, i8* %arrayidx.i209.i, align 1, !tbaa !6
  %648 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i207.i = getelementptr inbounds i8, i8* %0, i64 %648
  %649 = load i8, i8* %arrayidx.i207.i, align 1, !tbaa !6
  %add.i208.i = add i8 %649, 1
  store i8 %add.i208.i, i8* %arrayidx.i207.i, align 1, !tbaa !6
  %650 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i205.i = getelementptr inbounds i8, i8* %0, i64 %650
  %651 = load i8, i8* %arrayidx.i205.i, align 1, !tbaa !6
  %add.i206.i = add i8 %651, 1
  store i8 %add.i206.i, i8* %arrayidx.i205.i, align 1, !tbaa !6
  %652 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i203.i = getelementptr inbounds i8, i8* %0, i64 %652
  %653 = load i8, i8* %arrayidx.i203.i, align 1, !tbaa !6
  %add.i204.i = add i8 %653, 1
  store i8 %add.i204.i, i8* %arrayidx.i203.i, align 1, !tbaa !6
  %654 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i201.i = getelementptr inbounds i8, i8* %0, i64 %654
  %655 = load i8, i8* %arrayidx.i201.i, align 1, !tbaa !6
  %add.i202.i = add i8 %655, 1
  store i8 %add.i202.i, i8* %arrayidx.i201.i, align 1, !tbaa !6
  %656 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i199.i = getelementptr inbounds i8, i8* %0, i64 %656
  %657 = load i8, i8* %arrayidx.i199.i, align 1, !tbaa !6
  %add.i200.i = add i8 %657, 1
  store i8 %add.i200.i, i8* %arrayidx.i199.i, align 1, !tbaa !6
  %658 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i197.i = getelementptr inbounds i8, i8* %0, i64 %658
  %659 = load i8, i8* %arrayidx.i197.i, align 1, !tbaa !6
  %add.i198.i = add i8 %659, 1
  store i8 %add.i198.i, i8* %arrayidx.i197.i, align 1, !tbaa !6
  %660 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i195.i = getelementptr inbounds i8, i8* %0, i64 %660
  %661 = load i8, i8* %arrayidx.i195.i, align 1, !tbaa !6
  %add.i196.i = add i8 %661, 1
  store i8 %add.i196.i, i8* %arrayidx.i195.i, align 1, !tbaa !6
  %662 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i193.i = getelementptr inbounds i8, i8* %0, i64 %662
  %663 = load i8, i8* %arrayidx.i193.i, align 1, !tbaa !6
  %add.i194.i = add i8 %663, 1
  store i8 %add.i194.i, i8* %arrayidx.i193.i, align 1, !tbaa !6
  %664 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i191.i = getelementptr inbounds i8, i8* %0, i64 %664
  %665 = load i8, i8* %arrayidx.i191.i, align 1, !tbaa !6
  %add.i192.i = add i8 %665, 1
  store i8 %add.i192.i, i8* %arrayidx.i191.i, align 1, !tbaa !6
  %666 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i189.i = getelementptr inbounds i8, i8* %0, i64 %666
  %667 = load i8, i8* %arrayidx.i189.i, align 1, !tbaa !6
  %add.i190.i = add i8 %667, 1
  store i8 %add.i190.i, i8* %arrayidx.i189.i, align 1, !tbaa !6
  %668 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i187.i = getelementptr inbounds i8, i8* %0, i64 %668
  %669 = load i8, i8* %arrayidx.i187.i, align 1, !tbaa !6
  %add.i188.i = add i8 %669, 1
  store i8 %add.i188.i, i8* %arrayidx.i187.i, align 1, !tbaa !6
  %670 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i185.i = getelementptr inbounds i8, i8* %0, i64 %670
  %671 = load i8, i8* %arrayidx.i185.i, align 1, !tbaa !6
  %add.i186.i = add i8 %671, 1
  store i8 %add.i186.i, i8* %arrayidx.i185.i, align 1, !tbaa !6
  %672 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i183.i = getelementptr inbounds i8, i8* %0, i64 %672
  %673 = load i8, i8* %arrayidx.i183.i, align 1, !tbaa !6
  %add.i184.i = add i8 %673, 1
  store i8 %add.i184.i, i8* %arrayidx.i183.i, align 1, !tbaa !6
  %674 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i181.i = getelementptr inbounds i8, i8* %0, i64 %674
  %675 = load i8, i8* %arrayidx.i181.i, align 1, !tbaa !6
  %add.i182.i = add i8 %675, 1
  store i8 %add.i182.i, i8* %arrayidx.i181.i, align 1, !tbaa !6
  %676 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i179.i = getelementptr inbounds i8, i8* %0, i64 %676
  %677 = load i8, i8* %arrayidx.i179.i, align 1, !tbaa !6
  %add.i180.i = add i8 %677, 1
  store i8 %add.i180.i, i8* %arrayidx.i179.i, align 1, !tbaa !6
  %678 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i177.i = getelementptr inbounds i8, i8* %0, i64 %678
  %679 = load i8, i8* %arrayidx.i177.i, align 1, !tbaa !6
  %add.i178.i = add i8 %679, 1
  store i8 %add.i178.i, i8* %arrayidx.i177.i, align 1, !tbaa !6
  %680 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i175.i = getelementptr inbounds i8, i8* %0, i64 %680
  %681 = load i8, i8* %arrayidx.i175.i, align 1, !tbaa !6
  %add.i176.i = add i8 %681, 1
  store i8 %add.i176.i, i8* %arrayidx.i175.i, align 1, !tbaa !6
  %682 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i173.i = getelementptr inbounds i8, i8* %0, i64 %682
  %683 = load i8, i8* %arrayidx.i173.i, align 1, !tbaa !6
  %add.i174.i = add i8 %683, 1
  store i8 %add.i174.i, i8* %arrayidx.i173.i, align 1, !tbaa !6
  %684 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i171.i = getelementptr inbounds i8, i8* %0, i64 %684
  %685 = load i8, i8* %arrayidx.i171.i, align 1, !tbaa !6
  %add.i172.i = add i8 %685, 1
  store i8 %add.i172.i, i8* %arrayidx.i171.i, align 1, !tbaa !6
  %686 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i169.i = getelementptr inbounds i8, i8* %0, i64 %686
  %687 = load i8, i8* %arrayidx.i169.i, align 1, !tbaa !6
  %add.i170.i = add i8 %687, 1
  store i8 %add.i170.i, i8* %arrayidx.i169.i, align 1, !tbaa !6
  %688 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i167.i = getelementptr inbounds i8, i8* %0, i64 %688
  %689 = load i8, i8* %arrayidx.i167.i, align 1, !tbaa !6
  %add.i168.i = add i8 %689, 1
  store i8 %add.i168.i, i8* %arrayidx.i167.i, align 1, !tbaa !6
  %690 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i165.i = getelementptr inbounds i8, i8* %0, i64 %690
  %691 = load i8, i8* %arrayidx.i165.i, align 1, !tbaa !6
  %add.i166.i = add i8 %691, 1
  store i8 %add.i166.i, i8* %arrayidx.i165.i, align 1, !tbaa !6
  %692 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i163.i = getelementptr inbounds i8, i8* %0, i64 %692
  %693 = load i8, i8* %arrayidx.i163.i, align 1, !tbaa !6
  %add.i164.i = add i8 %693, 1
  store i8 %add.i164.i, i8* %arrayidx.i163.i, align 1, !tbaa !6
  %694 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i161.i = getelementptr inbounds i8, i8* %0, i64 %694
  %695 = load i8, i8* %arrayidx.i161.i, align 1, !tbaa !6
  %add.i162.i = add i8 %695, 1
  store i8 %add.i162.i, i8* %arrayidx.i161.i, align 1, !tbaa !6
  %696 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i156.i = getelementptr inbounds i8, i8* %0, i64 %696
  %697 = load i8, i8* %arrayidx.i156.i, align 1, !tbaa !6
  %conv.i157.i = zext i8 %697 to i32
  %698 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i158.i = call i32 @putc(i32 %conv.i157.i, %struct._IO_FILE* %698) #9
  br label %699

699:                                              ; preds = %702, %598
  %700 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i155.i = getelementptr inbounds i8, i8* %0, i64 %700
  %701 = load i8, i8* %arrayidx.i155.i, align 1, !tbaa !6
  %.not6.i = icmp eq i8 %701, 0
  br i1 %.not6.i, label %705, label %702

702:                                              ; preds = %699
  %703 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i153.i = getelementptr inbounds i8, i8* %0, i64 %703
  %704 = load i8, i8* %arrayidx.i153.i, align 1, !tbaa !6
  %add.i154.i = add i8 %704, -1
  store i8 %add.i154.i, i8* %arrayidx.i153.i, align 1, !tbaa !6
  br label %699

705:                                              ; preds = %699
  %706 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i152.i = add i64 %706, -1
  store i64 %add.i152.i, i64* %ptr.i, align 8, !tbaa !2
  %707 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i151.i = add i64 %707, -1
  store i64 %add.i151.i, i64* %ptr.i, align 8, !tbaa !2
  %708 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i150.i = add i64 %708, -1
  store i64 %add.i150.i, i64* %ptr.i, align 8, !tbaa !2
  %709 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i149.i = add i64 %709, -1
  store i64 %add.i149.i, i64* %ptr.i, align 8, !tbaa !2
  %710 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i148.i = add i64 %710, -1
  store i64 %add.i148.i, i64* %ptr.i, align 8, !tbaa !2
  %711 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i147.i = add i64 %711, -1
  store i64 %add.i147.i, i64* %ptr.i, align 8, !tbaa !2
  %712 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i146.i = add i64 %712, -1
  store i64 %add.i146.i, i64* %ptr.i, align 8, !tbaa !2
  %713 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i145.i = add i64 %713, -1
  store i64 %add.i145.i, i64* %ptr.i, align 8, !tbaa !2
  %714 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i144.i = add i64 %714, -1
  store i64 %add.i144.i, i64* %ptr.i, align 8, !tbaa !2
  %715 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i143.i = add i64 %715, -1
  store i64 %add.i143.i, i64* %ptr.i, align 8, !tbaa !2
  %716 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i142.i = add i64 %716, -1
  store i64 %add.i142.i, i64* %ptr.i, align 8, !tbaa !2
  %717 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i141.i = add i64 %717, -1
  store i64 %add.i141.i, i64* %ptr.i, align 8, !tbaa !2
  br label %718

718:                                              ; preds = %721, %705
  %719 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i140.i = getelementptr inbounds i8, i8* %0, i64 %719
  %720 = load i8, i8* %arrayidx.i140.i, align 1, !tbaa !6
  %.not7.i = icmp eq i8 %720, 0
  br i1 %.not7.i, label %736, label %721

721:                                              ; preds = %718
  %722 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i139.i = add i64 %722, 1
  store i64 %add.i139.i, i64* %ptr.i, align 8, !tbaa !2
  %723 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i138.i = add i64 %723, 1
  store i64 %add.i138.i, i64* %ptr.i, align 8, !tbaa !2
  %724 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i137.i = add i64 %724, 1
  store i64 %add.i137.i, i64* %ptr.i, align 8, !tbaa !2
  %725 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i135.i = getelementptr inbounds i8, i8* %0, i64 %725
  %726 = load i8, i8* %arrayidx.i135.i, align 1, !tbaa !6
  %add.i136.i = add i8 %726, 1
  store i8 %add.i136.i, i8* %arrayidx.i135.i, align 1, !tbaa !6
  %727 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i134.i = add i64 %727, 1
  store i64 %add.i134.i, i64* %ptr.i, align 8, !tbaa !2
  %728 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i132.i = getelementptr inbounds i8, i8* %0, i64 %728
  %729 = load i8, i8* %arrayidx.i132.i, align 1, !tbaa !6
  %add.i133.i = add i8 %729, 1
  store i8 %add.i133.i, i8* %arrayidx.i132.i, align 1, !tbaa !6
  %730 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i131.i = add i64 %730, -1
  store i64 %add.i131.i, i64* %ptr.i, align 8, !tbaa !2
  %731 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i130.i = add i64 %731, -1
  store i64 %add.i130.i, i64* %ptr.i, align 8, !tbaa !2
  %732 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i129.i = add i64 %732, -1
  store i64 %add.i129.i, i64* %ptr.i, align 8, !tbaa !2
  %733 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i128.i = add i64 %733, -1
  store i64 %add.i128.i, i64* %ptr.i, align 8, !tbaa !2
  %734 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i126.i = getelementptr inbounds i8, i8* %0, i64 %734
  %735 = load i8, i8* %arrayidx.i126.i, align 1, !tbaa !6
  %add.i127.i = add i8 %735, -1
  store i8 %add.i127.i, i8* %arrayidx.i126.i, align 1, !tbaa !6
  br label %718

736:                                              ; preds = %718
  %737 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i125.i = add i64 %737, 1
  store i64 %add.i125.i, i64* %ptr.i, align 8, !tbaa !2
  %738 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i124.i = add i64 %738, 1
  store i64 %add.i124.i, i64* %ptr.i, align 8, !tbaa !2
  %739 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i123.i = add i64 %739, 1
  store i64 %add.i123.i, i64* %ptr.i, align 8, !tbaa !2
  %740 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i122.i = add i64 %740, 1
  store i64 %add.i122.i, i64* %ptr.i, align 8, !tbaa !2
  br label %741

741:                                              ; preds = %744, %736
  %742 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i121.i = getelementptr inbounds i8, i8* %0, i64 %742
  %743 = load i8, i8* %arrayidx.i121.i, align 1, !tbaa !6
  %.not8.i = icmp eq i8 %743, 0
  br i1 %.not8.i, label %757, label %744

744:                                              ; preds = %741
  %745 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i120.i = add i64 %745, -1
  store i64 %add.i120.i, i64* %ptr.i, align 8, !tbaa !2
  %746 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i119.i = add i64 %746, -1
  store i64 %add.i119.i, i64* %ptr.i, align 8, !tbaa !2
  %747 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i118.i = add i64 %747, -1
  store i64 %add.i118.i, i64* %ptr.i, align 8, !tbaa !2
  %748 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i117.i = add i64 %748, -1
  store i64 %add.i117.i, i64* %ptr.i, align 8, !tbaa !2
  %749 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i115.i = getelementptr inbounds i8, i8* %0, i64 %749
  %750 = load i8, i8* %arrayidx.i115.i, align 1, !tbaa !6
  %add.i116.i = add i8 %750, 1
  store i8 %add.i116.i, i8* %arrayidx.i115.i, align 1, !tbaa !6
  %751 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i114.i = add i64 %751, 1
  store i64 %add.i114.i, i64* %ptr.i, align 8, !tbaa !2
  %752 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i113.i = add i64 %752, 1
  store i64 %add.i113.i, i64* %ptr.i, align 8, !tbaa !2
  %753 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i112.i = add i64 %753, 1
  store i64 %add.i112.i, i64* %ptr.i, align 8, !tbaa !2
  %754 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i111.i = add i64 %754, 1
  store i64 %add.i111.i, i64* %ptr.i, align 8, !tbaa !2
  %755 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i109.i = getelementptr inbounds i8, i8* %0, i64 %755
  %756 = load i8, i8* %arrayidx.i109.i, align 1, !tbaa !6
  %add.i110.i = add i8 %756, -1
  store i8 %add.i110.i, i8* %arrayidx.i109.i, align 1, !tbaa !6
  br label %741

757:                                              ; preds = %741
  %758 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i108.i = add i64 %758, -1
  store i64 %add.i108.i, i64* %ptr.i, align 8, !tbaa !2
  %759 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i106.i = getelementptr inbounds i8, i8* %0, i64 %759
  %760 = load i8, i8* %arrayidx.i106.i, align 1, !tbaa !6
  %add.i107.i = add i8 %760, -1
  store i8 %add.i107.i, i8* %arrayidx.i106.i, align 1, !tbaa !6
  br label %.loopexit35.i

.loopexit35.loopexit.i:                           ; preds = %779
  br label %.loopexit35.i

.loopexit35.i:                                    ; preds = %.loopexit35.loopexit.i, %757
  %761 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i105.i = getelementptr inbounds i8, i8* %0, i64 %761
  %762 = load i8, i8* %arrayidx.i105.i, align 1, !tbaa !6
  %.not9.i = icmp eq i8 %762, 0
  br i1 %.not9.i, label %776, label %763

763:                                              ; preds = %.loopexit35.i
  %764 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i104.i = add i64 %764, 1
  store i64 %add.i104.i, i64* %ptr.i, align 8, !tbaa !2
  %765 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i103.i = add i64 %765, 1
  store i64 %add.i103.i, i64* %ptr.i, align 8, !tbaa !2
  %766 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i98.i = getelementptr inbounds i8, i8* %0, i64 %766
  %767 = load i8, i8* %arrayidx.i98.i, align 1, !tbaa !6
  %conv.i99.i = zext i8 %767 to i32
  %768 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i100.i = call i32 @putc(i32 %conv.i99.i, %struct._IO_FILE* %768) #9
  %769 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i97.i = add i64 %769, 1
  store i64 %add.i97.i, i64* %ptr.i, align 8, !tbaa !2
  %770 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i94.i = getelementptr inbounds i8, i8* %0, i64 %770
  %771 = load i8, i8* %arrayidx.i94.i, align 1, !tbaa !6
  %conv.i.i = zext i8 %771 to i32
  %772 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i.i = call i32 @putc(i32 %conv.i.i, %struct._IO_FILE* %772) #9
  %773 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i93.i = add i64 %773, -1
  store i64 %add.i93.i, i64* %ptr.i, align 8, !tbaa !2
  %774 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i92.i = add i64 %774, -1
  store i64 %add.i92.i, i64* %ptr.i, align 8, !tbaa !2
  %775 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i91.i = add i64 %775, -1
  store i64 %add.i91.i, i64* %ptr.i, align 8, !tbaa !2
  br label %779

776:                                              ; preds = %.loopexit35.i
  %777 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i90.i = add i64 %777, -1
  store i64 %add.i90.i, i64* %ptr.i, align 8, !tbaa !2
  %778 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i89.i = add i64 %778, -1
  store i64 %add.i89.i, i64* %ptr.i, align 8, !tbaa !2
  br label %785

779:                                              ; preds = %782, %763
  %780 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i88.i = getelementptr inbounds i8, i8* %0, i64 %780
  %781 = load i8, i8* %arrayidx.i88.i, align 1, !tbaa !6
  %.not14.i = icmp eq i8 %781, 0
  br i1 %.not14.i, label %.loopexit35.loopexit.i, label %782

782:                                              ; preds = %779
  %783 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i86.i = getelementptr inbounds i8, i8* %0, i64 %783
  %784 = load i8, i8* %arrayidx.i86.i, align 1, !tbaa !6
  %add.i87.i = add i8 %784, -1
  store i8 %add.i87.i, i8* %arrayidx.i86.i, align 1, !tbaa !6
  br label %779

785:                                              ; preds = %788, %776
  %786 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i85.i = getelementptr inbounds i8, i8* %0, i64 %786
  %787 = load i8, i8* %arrayidx.i85.i, align 1, !tbaa !6
  %.not10.i = icmp eq i8 %787, 0
  br i1 %.not10.i, label %801, label %788

788:                                              ; preds = %785
  %789 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i84.i = add i64 %789, 1
  store i64 %add.i84.i, i64* %ptr.i, align 8, !tbaa !2
  %790 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i83.i = add i64 %790, 1
  store i64 %add.i83.i, i64* %ptr.i, align 8, !tbaa !2
  %791 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i81.i = getelementptr inbounds i8, i8* %0, i64 %791
  %792 = load i8, i8* %arrayidx.i81.i, align 1, !tbaa !6
  %add.i82.i = add i8 %792, 1
  store i8 %add.i82.i, i8* %arrayidx.i81.i, align 1, !tbaa !6
  %793 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i80.i = add i64 %793, 1
  store i64 %add.i80.i, i64* %ptr.i, align 8, !tbaa !2
  %794 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i78.i = getelementptr inbounds i8, i8* %0, i64 %794
  %795 = load i8, i8* %arrayidx.i78.i, align 1, !tbaa !6
  %add.i79.i = add i8 %795, 1
  store i8 %add.i79.i, i8* %arrayidx.i78.i, align 1, !tbaa !6
  %796 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i77.i = add i64 %796, -1
  store i64 %add.i77.i, i64* %ptr.i, align 8, !tbaa !2
  %797 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i76.i = add i64 %797, -1
  store i64 %add.i76.i, i64* %ptr.i, align 8, !tbaa !2
  %798 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i75.i = add i64 %798, -1
  store i64 %add.i75.i, i64* %ptr.i, align 8, !tbaa !2
  %799 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i73.i = getelementptr inbounds i8, i8* %0, i64 %799
  %800 = load i8, i8* %arrayidx.i73.i, align 1, !tbaa !6
  %add.i74.i = add i8 %800, -1
  store i8 %add.i74.i, i8* %arrayidx.i73.i, align 1, !tbaa !6
  br label %785

801:                                              ; preds = %785
  %802 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i72.i = add i64 %802, 1
  store i64 %add.i72.i, i64* %ptr.i, align 8, !tbaa !2
  %803 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i71.i = add i64 %803, 1
  store i64 %add.i71.i, i64* %ptr.i, align 8, !tbaa !2
  %804 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i70.i = add i64 %804, 1
  store i64 %add.i70.i, i64* %ptr.i, align 8, !tbaa !2
  br label %805

805:                                              ; preds = %808, %801
  %806 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i69.i = getelementptr inbounds i8, i8* %0, i64 %806
  %807 = load i8, i8* %arrayidx.i69.i, align 1, !tbaa !6
  %.not11.i = icmp eq i8 %807, 0
  br i1 %.not11.i, label %819, label %808

808:                                              ; preds = %805
  %809 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i68.i = add i64 %809, -1
  store i64 %add.i68.i, i64* %ptr.i, align 8, !tbaa !2
  %810 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i67.i = add i64 %810, -1
  store i64 %add.i67.i, i64* %ptr.i, align 8, !tbaa !2
  %811 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i66.i = add i64 %811, -1
  store i64 %add.i66.i, i64* %ptr.i, align 8, !tbaa !2
  %812 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i64.i = getelementptr inbounds i8, i8* %0, i64 %812
  %813 = load i8, i8* %arrayidx.i64.i, align 1, !tbaa !6
  %add.i65.i = add i8 %813, 1
  store i8 %add.i65.i, i8* %arrayidx.i64.i, align 1, !tbaa !6
  %814 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i63.i = add i64 %814, 1
  store i64 %add.i63.i, i64* %ptr.i, align 8, !tbaa !2
  %815 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i62.i = add i64 %815, 1
  store i64 %add.i62.i, i64* %ptr.i, align 8, !tbaa !2
  %816 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i61.i = add i64 %816, 1
  store i64 %add.i61.i, i64* %ptr.i, align 8, !tbaa !2
  %817 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i59.i = getelementptr inbounds i8, i8* %0, i64 %817
  %818 = load i8, i8* %arrayidx.i59.i, align 1, !tbaa !6
  %add.i60.i = add i8 %818, -1
  store i8 %add.i60.i, i8* %arrayidx.i59.i, align 1, !tbaa !6
  br label %805

819:                                              ; preds = %805
  %820 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i58.i = add i64 %820, -1
  store i64 %add.i58.i, i64* %ptr.i, align 8, !tbaa !2
  %821 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i57.i = add i64 %821, -1
  store i64 %add.i57.i, i64* %ptr.i, align 8, !tbaa !2
  br label %822

822:                                              ; preds = %825, %819
  %823 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i56.i = getelementptr inbounds i8, i8* %0, i64 %823
  %824 = load i8, i8* %arrayidx.i56.i, align 1, !tbaa !6
  %.not12.i = icmp eq i8 %824, 0
  br i1 %.not12.i, label %832, label %825

825:                                              ; preds = %822
  %826 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i55.i = add i64 %826, -1
  store i64 %add.i55.i, i64* %ptr.i, align 8, !tbaa !2
  %827 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i53.i = getelementptr inbounds i8, i8* %0, i64 %827
  %828 = load i8, i8* %arrayidx.i53.i, align 1, !tbaa !6
  %add.i54.i = add i8 %828, 1
  store i8 %add.i54.i, i8* %arrayidx.i53.i, align 1, !tbaa !6
  %829 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i52.i = add i64 %829, 1
  store i64 %add.i52.i, i64* %ptr.i, align 8, !tbaa !2
  %830 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i50.i = getelementptr inbounds i8, i8* %0, i64 %830
  %831 = load i8, i8* %arrayidx.i50.i, align 1, !tbaa !6
  %add.i51.i = add i8 %831, -1
  store i8 %add.i51.i, i8* %arrayidx.i50.i, align 1, !tbaa !6
  br label %822

832:                                              ; preds = %822
  %833 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i49.i = add i64 %833, 1
  store i64 %add.i49.i, i64* %ptr.i, align 8, !tbaa !2
  br label %834

834:                                              ; preds = %837, %832
  %835 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i48.i = getelementptr inbounds i8, i8* %0, i64 %835
  %836 = load i8, i8* %arrayidx.i48.i, align 1, !tbaa !6
  %.not13.i = icmp eq i8 %836, 0
  br i1 %.not13.i, label %844, label %837

837:                                              ; preds = %834
  %838 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i47.i = add i64 %838, -1
  store i64 %add.i47.i, i64* %ptr.i, align 8, !tbaa !2
  %839 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i45.i = getelementptr inbounds i8, i8* %0, i64 %839
  %840 = load i8, i8* %arrayidx.i45.i, align 1, !tbaa !6
  %add.i46.i = add i8 %840, 1
  store i8 %add.i46.i, i8* %arrayidx.i45.i, align 1, !tbaa !6
  %841 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i44.i = add i64 %841, 1
  store i64 %add.i44.i, i64* %ptr.i, align 8, !tbaa !2
  %842 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i42.i = getelementptr inbounds i8, i8* %0, i64 %842
  %843 = load i8, i8* %arrayidx.i42.i, align 1, !tbaa !6
  %add.i43.i = add i8 %843, -1
  store i8 %add.i43.i, i8* %arrayidx.i42.i, align 1, !tbaa !6
  br label %834

844:                                              ; preds = %834
  %845 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i41.i = add i64 %845, -1
  store i64 %add.i41.i, i64* %ptr.i, align 8, !tbaa !2
  %846 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i40.i = add i64 %846, -1
  store i64 %add.i40.i, i64* %ptr.i, align 8, !tbaa !2
  %847 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %add.i39.i = add i64 %847, -1
  store i64 %add.i39.i, i64* %ptr.i, align 8, !tbaa !2
  %848 = load i64, i64* %ptr.i, align 8, !tbaa !2
  %arrayidx.i37.i = getelementptr inbounds i8, i8* %0, i64 %848
  %849 = load i8, i8* %arrayidx.i37.i, align 1, !tbaa !6
  %add.i38.i = add i8 %849, -1
  store i8 %add.i38.i, i8* %arrayidx.i37.i, align 1, !tbaa !6
  br label %190

hooked_stub.exit:                                 ; preds = %190
  %850 = bitcast i64* %ptr.i to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %850)
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
  %arrayidx.i95 = getelementptr inbounds i8, i8* %0, i64 %4
  %5 = load i8, i8* %arrayidx.i95, align 1, !tbaa !6
  %add.i96 = add i8 %5, 1
  store i8 %add.i96, i8* %arrayidx.i95, align 1, !tbaa !6
  %6 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i101 = getelementptr inbounds i8, i8* %0, i64 %6
  %7 = load i8, i8* %arrayidx.i101, align 1, !tbaa !6
  %add.i102 = add i8 %7, 1
  store i8 %add.i102, i8* %arrayidx.i101, align 1, !tbaa !6
  %8 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i159 = getelementptr inbounds i8, i8* %0, i64 %8
  %9 = load i8, i8* %arrayidx.i159, align 1, !tbaa !6
  %add.i160 = add i8 %9, 1
  store i8 %add.i160, i8* %arrayidx.i159, align 1, !tbaa !6
  %10 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i291 = getelementptr inbounds i8, i8* %0, i64 %10
  %11 = load i8, i8* %arrayidx.i291, align 1, !tbaa !6
  %add.i292 = add i8 %11, 1
  store i8 %add.i292, i8* %arrayidx.i291, align 1, !tbaa !6
  %12 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i766 = getelementptr inbounds i8, i8* %0, i64 %12
  %13 = load i8, i8* %arrayidx.i766, align 1, !tbaa !6
  %add.i767 = add i8 %13, 1
  store i8 %add.i767, i8* %arrayidx.i766, align 1, !tbaa !6
  %14 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i764 = getelementptr inbounds i8, i8* %0, i64 %14
  %15 = load i8, i8* %arrayidx.i764, align 1, !tbaa !6
  %add.i765 = add i8 %15, 1
  store i8 %add.i765, i8* %arrayidx.i764, align 1, !tbaa !6
  %16 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i762 = getelementptr inbounds i8, i8* %0, i64 %16
  %17 = load i8, i8* %arrayidx.i762, align 1, !tbaa !6
  %add.i763 = add i8 %17, 1
  store i8 %add.i763, i8* %arrayidx.i762, align 1, !tbaa !6
  %18 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i760 = getelementptr inbounds i8, i8* %0, i64 %18
  %19 = load i8, i8* %arrayidx.i760, align 1, !tbaa !6
  %add.i761 = add i8 %19, 1
  store i8 %add.i761, i8* %arrayidx.i760, align 1, !tbaa !6
  %20 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i758 = getelementptr inbounds i8, i8* %0, i64 %20
  %21 = load i8, i8* %arrayidx.i758, align 1, !tbaa !6
  %add.i759 = add i8 %21, 1
  store i8 %add.i759, i8* %arrayidx.i758, align 1, !tbaa !6
  %22 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i756 = getelementptr inbounds i8, i8* %0, i64 %22
  %23 = load i8, i8* %arrayidx.i756, align 1, !tbaa !6
  %add.i757 = add i8 %23, 1
  store i8 %add.i757, i8* %arrayidx.i756, align 1, !tbaa !6
  %24 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i755 = add i64 %24, 1
  store i64 %add.i755, i64* %ptr, align 8, !tbaa !2
  %25 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i753 = getelementptr inbounds i8, i8* %0, i64 %25
  %26 = load i8, i8* %arrayidx.i753, align 1, !tbaa !6
  %add.i754 = add i8 %26, 1
  store i8 %add.i754, i8* %arrayidx.i753, align 1, !tbaa !6
  %27 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i752 = add i64 %27, 1
  store i64 %add.i752, i64* %ptr, align 8, !tbaa !2
  %28 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i751 = add i64 %28, 1
  store i64 %add.i751, i64* %ptr, align 8, !tbaa !2
  %29 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i750 = add i64 %29, 1
  store i64 %add.i750, i64* %ptr, align 8, !tbaa !2
  %30 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i749 = add i64 %30, 1
  store i64 %add.i749, i64* %ptr, align 8, !tbaa !2
  %31 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i747 = getelementptr inbounds i8, i8* %0, i64 %31
  %32 = load i8, i8* %arrayidx.i747, align 1, !tbaa !6
  %add.i748 = add i8 %32, 1
  store i8 %add.i748, i8* %arrayidx.i747, align 1, !tbaa !6
  %33 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i745 = getelementptr inbounds i8, i8* %0, i64 %33
  %34 = load i8, i8* %arrayidx.i745, align 1, !tbaa !6
  %add.i746 = add i8 %34, 1
  store i8 %add.i746, i8* %arrayidx.i745, align 1, !tbaa !6
  %35 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i743 = getelementptr inbounds i8, i8* %0, i64 %35
  %36 = load i8, i8* %arrayidx.i743, align 1, !tbaa !6
  %add.i744 = add i8 %36, 1
  store i8 %add.i744, i8* %arrayidx.i743, align 1, !tbaa !6
  %37 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i741 = getelementptr inbounds i8, i8* %0, i64 %37
  %38 = load i8, i8* %arrayidx.i741, align 1, !tbaa !6
  %add.i742 = add i8 %38, 1
  store i8 %add.i742, i8* %arrayidx.i741, align 1, !tbaa !6
  %39 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i739 = getelementptr inbounds i8, i8* %0, i64 %39
  %40 = load i8, i8* %arrayidx.i739, align 1, !tbaa !6
  %add.i740 = add i8 %40, 1
  store i8 %add.i740, i8* %arrayidx.i739, align 1, !tbaa !6
  %41 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i737 = getelementptr inbounds i8, i8* %0, i64 %41
  %42 = load i8, i8* %arrayidx.i737, align 1, !tbaa !6
  %add.i738 = add i8 %42, 1
  store i8 %add.i738, i8* %arrayidx.i737, align 1, !tbaa !6
  %43 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i735 = getelementptr inbounds i8, i8* %0, i64 %43
  %44 = load i8, i8* %arrayidx.i735, align 1, !tbaa !6
  %add.i736 = add i8 %44, 1
  store i8 %add.i736, i8* %arrayidx.i735, align 1, !tbaa !6
  %45 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i733 = getelementptr inbounds i8, i8* %0, i64 %45
  %46 = load i8, i8* %arrayidx.i733, align 1, !tbaa !6
  %add.i734 = add i8 %46, 1
  store i8 %add.i734, i8* %arrayidx.i733, align 1, !tbaa !6
  %47 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i731 = getelementptr inbounds i8, i8* %0, i64 %47
  %48 = load i8, i8* %arrayidx.i731, align 1, !tbaa !6
  %add.i732 = add i8 %48, 1
  store i8 %add.i732, i8* %arrayidx.i731, align 1, !tbaa !6
  %49 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i729 = getelementptr inbounds i8, i8* %0, i64 %49
  %50 = load i8, i8* %arrayidx.i729, align 1, !tbaa !6
  %add.i730 = add i8 %50, 1
  store i8 %add.i730, i8* %arrayidx.i729, align 1, !tbaa !6
  %51 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i727 = getelementptr inbounds i8, i8* %0, i64 %51
  %52 = load i8, i8* %arrayidx.i727, align 1, !tbaa !6
  %add.i728 = add i8 %52, 1
  store i8 %add.i728, i8* %arrayidx.i727, align 1, !tbaa !6
  %53 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i725 = getelementptr inbounds i8, i8* %0, i64 %53
  %54 = load i8, i8* %arrayidx.i725, align 1, !tbaa !6
  %add.i726 = add i8 %54, 1
  store i8 %add.i726, i8* %arrayidx.i725, align 1, !tbaa !6
  %55 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i723 = getelementptr inbounds i8, i8* %0, i64 %55
  %56 = load i8, i8* %arrayidx.i723, align 1, !tbaa !6
  %add.i724 = add i8 %56, 1
  store i8 %add.i724, i8* %arrayidx.i723, align 1, !tbaa !6
  %57 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i721 = getelementptr inbounds i8, i8* %0, i64 %57
  %58 = load i8, i8* %arrayidx.i721, align 1, !tbaa !6
  %add.i722 = add i8 %58, 1
  store i8 %add.i722, i8* %arrayidx.i721, align 1, !tbaa !6
  %59 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i719 = getelementptr inbounds i8, i8* %0, i64 %59
  %60 = load i8, i8* %arrayidx.i719, align 1, !tbaa !6
  %add.i720 = add i8 %60, 1
  store i8 %add.i720, i8* %arrayidx.i719, align 1, !tbaa !6
  %61 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i717 = getelementptr inbounds i8, i8* %0, i64 %61
  %62 = load i8, i8* %arrayidx.i717, align 1, !tbaa !6
  %add.i718 = add i8 %62, 1
  store i8 %add.i718, i8* %arrayidx.i717, align 1, !tbaa !6
  %63 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i715 = getelementptr inbounds i8, i8* %0, i64 %63
  %64 = load i8, i8* %arrayidx.i715, align 1, !tbaa !6
  %add.i716 = add i8 %64, 1
  store i8 %add.i716, i8* %arrayidx.i715, align 1, !tbaa !6
  %65 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i713 = getelementptr inbounds i8, i8* %0, i64 %65
  %66 = load i8, i8* %arrayidx.i713, align 1, !tbaa !6
  %add.i714 = add i8 %66, 1
  store i8 %add.i714, i8* %arrayidx.i713, align 1, !tbaa !6
  %67 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i711 = getelementptr inbounds i8, i8* %0, i64 %67
  %68 = load i8, i8* %arrayidx.i711, align 1, !tbaa !6
  %add.i712 = add i8 %68, 1
  store i8 %add.i712, i8* %arrayidx.i711, align 1, !tbaa !6
  %69 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i709 = getelementptr inbounds i8, i8* %0, i64 %69
  %70 = load i8, i8* %arrayidx.i709, align 1, !tbaa !6
  %add.i710 = add i8 %70, 1
  store i8 %add.i710, i8* %arrayidx.i709, align 1, !tbaa !6
  %71 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i707 = getelementptr inbounds i8, i8* %0, i64 %71
  %72 = load i8, i8* %arrayidx.i707, align 1, !tbaa !6
  %add.i708 = add i8 %72, 1
  store i8 %add.i708, i8* %arrayidx.i707, align 1, !tbaa !6
  %73 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i705 = getelementptr inbounds i8, i8* %0, i64 %73
  %74 = load i8, i8* %arrayidx.i705, align 1, !tbaa !6
  %add.i706 = add i8 %74, 1
  store i8 %add.i706, i8* %arrayidx.i705, align 1, !tbaa !6
  %75 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i703 = getelementptr inbounds i8, i8* %0, i64 %75
  %76 = load i8, i8* %arrayidx.i703, align 1, !tbaa !6
  %add.i704 = add i8 %76, 1
  store i8 %add.i704, i8* %arrayidx.i703, align 1, !tbaa !6
  %77 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i701 = getelementptr inbounds i8, i8* %0, i64 %77
  %78 = load i8, i8* %arrayidx.i701, align 1, !tbaa !6
  %add.i702 = add i8 %78, 1
  store i8 %add.i702, i8* %arrayidx.i701, align 1, !tbaa !6
  %79 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i699 = getelementptr inbounds i8, i8* %0, i64 %79
  %80 = load i8, i8* %arrayidx.i699, align 1, !tbaa !6
  %add.i700 = add i8 %80, 1
  store i8 %add.i700, i8* %arrayidx.i699, align 1, !tbaa !6
  %81 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i697 = getelementptr inbounds i8, i8* %0, i64 %81
  %82 = load i8, i8* %arrayidx.i697, align 1, !tbaa !6
  %add.i698 = add i8 %82, 1
  store i8 %add.i698, i8* %arrayidx.i697, align 1, !tbaa !6
  %83 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i695 = getelementptr inbounds i8, i8* %0, i64 %83
  %84 = load i8, i8* %arrayidx.i695, align 1, !tbaa !6
  %add.i696 = add i8 %84, 1
  store i8 %add.i696, i8* %arrayidx.i695, align 1, !tbaa !6
  %85 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i693 = getelementptr inbounds i8, i8* %0, i64 %85
  %86 = load i8, i8* %arrayidx.i693, align 1, !tbaa !6
  %add.i694 = add i8 %86, 1
  store i8 %add.i694, i8* %arrayidx.i693, align 1, !tbaa !6
  %87 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i691 = getelementptr inbounds i8, i8* %0, i64 %87
  %88 = load i8, i8* %arrayidx.i691, align 1, !tbaa !6
  %add.i692 = add i8 %88, 1
  store i8 %add.i692, i8* %arrayidx.i691, align 1, !tbaa !6
  %89 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i689 = getelementptr inbounds i8, i8* %0, i64 %89
  %90 = load i8, i8* %arrayidx.i689, align 1, !tbaa !6
  %add.i690 = add i8 %90, 1
  store i8 %add.i690, i8* %arrayidx.i689, align 1, !tbaa !6
  %91 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i687 = getelementptr inbounds i8, i8* %0, i64 %91
  %92 = load i8, i8* %arrayidx.i687, align 1, !tbaa !6
  %add.i688 = add i8 %92, 1
  store i8 %add.i688, i8* %arrayidx.i687, align 1, !tbaa !6
  %93 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i685 = getelementptr inbounds i8, i8* %0, i64 %93
  %94 = load i8, i8* %arrayidx.i685, align 1, !tbaa !6
  %add.i686 = add i8 %94, 1
  store i8 %add.i686, i8* %arrayidx.i685, align 1, !tbaa !6
  %95 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i683 = getelementptr inbounds i8, i8* %0, i64 %95
  %96 = load i8, i8* %arrayidx.i683, align 1, !tbaa !6
  %add.i684 = add i8 %96, 1
  store i8 %add.i684, i8* %arrayidx.i683, align 1, !tbaa !6
  %97 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i681 = getelementptr inbounds i8, i8* %0, i64 %97
  %98 = load i8, i8* %arrayidx.i681, align 1, !tbaa !6
  %add.i682 = add i8 %98, 1
  store i8 %add.i682, i8* %arrayidx.i681, align 1, !tbaa !6
  %99 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i679 = getelementptr inbounds i8, i8* %0, i64 %99
  %100 = load i8, i8* %arrayidx.i679, align 1, !tbaa !6
  %add.i680 = add i8 %100, 1
  store i8 %add.i680, i8* %arrayidx.i679, align 1, !tbaa !6
  %101 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i677 = getelementptr inbounds i8, i8* %0, i64 %101
  %102 = load i8, i8* %arrayidx.i677, align 1, !tbaa !6
  %add.i678 = add i8 %102, 1
  store i8 %add.i678, i8* %arrayidx.i677, align 1, !tbaa !6
  %103 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i675 = getelementptr inbounds i8, i8* %0, i64 %103
  %104 = load i8, i8* %arrayidx.i675, align 1, !tbaa !6
  %add.i676 = add i8 %104, 1
  store i8 %add.i676, i8* %arrayidx.i675, align 1, !tbaa !6
  %105 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i673 = getelementptr inbounds i8, i8* %0, i64 %105
  %106 = load i8, i8* %arrayidx.i673, align 1, !tbaa !6
  %add.i674 = add i8 %106, 1
  store i8 %add.i674, i8* %arrayidx.i673, align 1, !tbaa !6
  %107 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i671 = getelementptr inbounds i8, i8* %0, i64 %107
  %108 = load i8, i8* %arrayidx.i671, align 1, !tbaa !6
  %add.i672 = add i8 %108, 1
  store i8 %add.i672, i8* %arrayidx.i671, align 1, !tbaa !6
  %109 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i669 = getelementptr inbounds i8, i8* %0, i64 %109
  %110 = load i8, i8* %arrayidx.i669, align 1, !tbaa !6
  %add.i670 = add i8 %110, 1
  store i8 %add.i670, i8* %arrayidx.i669, align 1, !tbaa !6
  %111 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i667 = getelementptr inbounds i8, i8* %0, i64 %111
  %112 = load i8, i8* %arrayidx.i667, align 1, !tbaa !6
  %add.i668 = add i8 %112, 1
  store i8 %add.i668, i8* %arrayidx.i667, align 1, !tbaa !6
  %113 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i665 = getelementptr inbounds i8, i8* %0, i64 %113
  %114 = load i8, i8* %arrayidx.i665, align 1, !tbaa !6
  %add.i666 = add i8 %114, 1
  store i8 %add.i666, i8* %arrayidx.i665, align 1, !tbaa !6
  %115 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i663 = getelementptr inbounds i8, i8* %0, i64 %115
  %116 = load i8, i8* %arrayidx.i663, align 1, !tbaa !6
  %add.i664 = add i8 %116, 1
  store i8 %add.i664, i8* %arrayidx.i663, align 1, !tbaa !6
  %117 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i661 = getelementptr inbounds i8, i8* %0, i64 %117
  %118 = load i8, i8* %arrayidx.i661, align 1, !tbaa !6
  %add.i662 = add i8 %118, 1
  store i8 %add.i662, i8* %arrayidx.i661, align 1, !tbaa !6
  %119 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i660 = add i64 %119, 1
  store i64 %add.i660, i64* %ptr, align 8, !tbaa !2
  %120 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i658 = getelementptr inbounds i8, i8* %0, i64 %120
  %121 = load i8, i8* %arrayidx.i658, align 1, !tbaa !6
  %add.i659 = add i8 %121, 1
  store i8 %add.i659, i8* %arrayidx.i658, align 1, !tbaa !6
  %122 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i656 = getelementptr inbounds i8, i8* %0, i64 %122
  %123 = load i8, i8* %arrayidx.i656, align 1, !tbaa !6
  %add.i657 = add i8 %123, 1
  store i8 %add.i657, i8* %arrayidx.i656, align 1, !tbaa !6
  %124 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i654 = getelementptr inbounds i8, i8* %0, i64 %124
  %125 = load i8, i8* %arrayidx.i654, align 1, !tbaa !6
  %add.i655 = add i8 %125, 1
  store i8 %add.i655, i8* %arrayidx.i654, align 1, !tbaa !6
  %126 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i652 = getelementptr inbounds i8, i8* %0, i64 %126
  %127 = load i8, i8* %arrayidx.i652, align 1, !tbaa !6
  %add.i653 = add i8 %127, 1
  store i8 %add.i653, i8* %arrayidx.i652, align 1, !tbaa !6
  %128 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i650 = getelementptr inbounds i8, i8* %0, i64 %128
  %129 = load i8, i8* %arrayidx.i650, align 1, !tbaa !6
  %add.i651 = add i8 %129, 1
  store i8 %add.i651, i8* %arrayidx.i650, align 1, !tbaa !6
  %130 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i648 = getelementptr inbounds i8, i8* %0, i64 %130
  %131 = load i8, i8* %arrayidx.i648, align 1, !tbaa !6
  %add.i649 = add i8 %131, 1
  store i8 %add.i649, i8* %arrayidx.i648, align 1, !tbaa !6
  %132 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i646 = getelementptr inbounds i8, i8* %0, i64 %132
  %133 = load i8, i8* %arrayidx.i646, align 1, !tbaa !6
  %add.i647 = add i8 %133, 1
  store i8 %add.i647, i8* %arrayidx.i646, align 1, !tbaa !6
  %134 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i644 = getelementptr inbounds i8, i8* %0, i64 %134
  %135 = load i8, i8* %arrayidx.i644, align 1, !tbaa !6
  %add.i645 = add i8 %135, 1
  store i8 %add.i645, i8* %arrayidx.i644, align 1, !tbaa !6
  %136 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i642 = getelementptr inbounds i8, i8* %0, i64 %136
  %137 = load i8, i8* %arrayidx.i642, align 1, !tbaa !6
  %add.i643 = add i8 %137, 1
  store i8 %add.i643, i8* %arrayidx.i642, align 1, !tbaa !6
  %138 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i640 = getelementptr inbounds i8, i8* %0, i64 %138
  %139 = load i8, i8* %arrayidx.i640, align 1, !tbaa !6
  %add.i641 = add i8 %139, 1
  store i8 %add.i641, i8* %arrayidx.i640, align 1, !tbaa !6
  %140 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i638 = getelementptr inbounds i8, i8* %0, i64 %140
  %141 = load i8, i8* %arrayidx.i638, align 1, !tbaa !6
  %add.i639 = add i8 %141, 1
  store i8 %add.i639, i8* %arrayidx.i638, align 1, !tbaa !6
  %142 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i636 = getelementptr inbounds i8, i8* %0, i64 %142
  %143 = load i8, i8* %arrayidx.i636, align 1, !tbaa !6
  %add.i637 = add i8 %143, 1
  store i8 %add.i637, i8* %arrayidx.i636, align 1, !tbaa !6
  %144 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i634 = getelementptr inbounds i8, i8* %0, i64 %144
  %145 = load i8, i8* %arrayidx.i634, align 1, !tbaa !6
  %add.i635 = add i8 %145, 1
  store i8 %add.i635, i8* %arrayidx.i634, align 1, !tbaa !6
  %146 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i632 = getelementptr inbounds i8, i8* %0, i64 %146
  %147 = load i8, i8* %arrayidx.i632, align 1, !tbaa !6
  %add.i633 = add i8 %147, 1
  store i8 %add.i633, i8* %arrayidx.i632, align 1, !tbaa !6
  %148 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i630 = getelementptr inbounds i8, i8* %0, i64 %148
  %149 = load i8, i8* %arrayidx.i630, align 1, !tbaa !6
  %add.i631 = add i8 %149, 1
  store i8 %add.i631, i8* %arrayidx.i630, align 1, !tbaa !6
  %150 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i628 = getelementptr inbounds i8, i8* %0, i64 %150
  %151 = load i8, i8* %arrayidx.i628, align 1, !tbaa !6
  %add.i629 = add i8 %151, 1
  store i8 %add.i629, i8* %arrayidx.i628, align 1, !tbaa !6
  %152 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i626 = getelementptr inbounds i8, i8* %0, i64 %152
  %153 = load i8, i8* %arrayidx.i626, align 1, !tbaa !6
  %add.i627 = add i8 %153, 1
  store i8 %add.i627, i8* %arrayidx.i626, align 1, !tbaa !6
  %154 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i624 = getelementptr inbounds i8, i8* %0, i64 %154
  %155 = load i8, i8* %arrayidx.i624, align 1, !tbaa !6
  %add.i625 = add i8 %155, 1
  store i8 %add.i625, i8* %arrayidx.i624, align 1, !tbaa !6
  %156 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i622 = getelementptr inbounds i8, i8* %0, i64 %156
  %157 = load i8, i8* %arrayidx.i622, align 1, !tbaa !6
  %add.i623 = add i8 %157, 1
  store i8 %add.i623, i8* %arrayidx.i622, align 1, !tbaa !6
  %158 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i620 = getelementptr inbounds i8, i8* %0, i64 %158
  %159 = load i8, i8* %arrayidx.i620, align 1, !tbaa !6
  %add.i621 = add i8 %159, 1
  store i8 %add.i621, i8* %arrayidx.i620, align 1, !tbaa !6
  %160 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i618 = getelementptr inbounds i8, i8* %0, i64 %160
  %161 = load i8, i8* %arrayidx.i618, align 1, !tbaa !6
  %add.i619 = add i8 %161, 1
  store i8 %add.i619, i8* %arrayidx.i618, align 1, !tbaa !6
  %162 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i616 = getelementptr inbounds i8, i8* %0, i64 %162
  %163 = load i8, i8* %arrayidx.i616, align 1, !tbaa !6
  %add.i617 = add i8 %163, 1
  store i8 %add.i617, i8* %arrayidx.i616, align 1, !tbaa !6
  %164 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i614 = getelementptr inbounds i8, i8* %0, i64 %164
  %165 = load i8, i8* %arrayidx.i614, align 1, !tbaa !6
  %add.i615 = add i8 %165, 1
  store i8 %add.i615, i8* %arrayidx.i614, align 1, !tbaa !6
  %166 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i612 = getelementptr inbounds i8, i8* %0, i64 %166
  %167 = load i8, i8* %arrayidx.i612, align 1, !tbaa !6
  %add.i613 = add i8 %167, 1
  store i8 %add.i613, i8* %arrayidx.i612, align 1, !tbaa !6
  %168 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i610 = getelementptr inbounds i8, i8* %0, i64 %168
  %169 = load i8, i8* %arrayidx.i610, align 1, !tbaa !6
  %add.i611 = add i8 %169, 1
  store i8 %add.i611, i8* %arrayidx.i610, align 1, !tbaa !6
  %170 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i608 = getelementptr inbounds i8, i8* %0, i64 %170
  %171 = load i8, i8* %arrayidx.i608, align 1, !tbaa !6
  %add.i609 = add i8 %171, 1
  store i8 %add.i609, i8* %arrayidx.i608, align 1, !tbaa !6
  %172 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i606 = getelementptr inbounds i8, i8* %0, i64 %172
  %173 = load i8, i8* %arrayidx.i606, align 1, !tbaa !6
  %add.i607 = add i8 %173, 1
  store i8 %add.i607, i8* %arrayidx.i606, align 1, !tbaa !6
  %174 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i604 = getelementptr inbounds i8, i8* %0, i64 %174
  %175 = load i8, i8* %arrayidx.i604, align 1, !tbaa !6
  %add.i605 = add i8 %175, 1
  store i8 %add.i605, i8* %arrayidx.i604, align 1, !tbaa !6
  %176 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i602 = getelementptr inbounds i8, i8* %0, i64 %176
  %177 = load i8, i8* %arrayidx.i602, align 1, !tbaa !6
  %add.i603 = add i8 %177, 1
  store i8 %add.i603, i8* %arrayidx.i602, align 1, !tbaa !6
  %178 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i600 = getelementptr inbounds i8, i8* %0, i64 %178
  %179 = load i8, i8* %arrayidx.i600, align 1, !tbaa !6
  %add.i601 = add i8 %179, 1
  store i8 %add.i601, i8* %arrayidx.i600, align 1, !tbaa !6
  %180 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i598 = getelementptr inbounds i8, i8* %0, i64 %180
  %181 = load i8, i8* %arrayidx.i598, align 1, !tbaa !6
  %add.i599 = add i8 %181, 1
  store i8 %add.i599, i8* %arrayidx.i598, align 1, !tbaa !6
  %182 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i596 = getelementptr inbounds i8, i8* %0, i64 %182
  %183 = load i8, i8* %arrayidx.i596, align 1, !tbaa !6
  %add.i597 = add i8 %183, 1
  store i8 %add.i597, i8* %arrayidx.i596, align 1, !tbaa !6
  %184 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i595 = add i64 %184, -1
  store i64 %add.i595, i64* %ptr, align 8, !tbaa !2
  %185 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i594 = add i64 %185, -1
  store i64 %add.i594, i64* %ptr, align 8, !tbaa !2
  %186 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i593 = add i64 %186, -1
  store i64 %add.i593, i64* %ptr, align 8, !tbaa !2
  %187 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i592 = add i64 %187, -1
  store i64 %add.i592, i64* %ptr, align 8, !tbaa !2
  %188 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i591 = add i64 %188, -1
  store i64 %add.i591, i64* %ptr, align 8, !tbaa !2
  %189 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i590 = add i64 %189, -1
  store i64 %add.i590, i64* %ptr, align 8, !tbaa !2
  br label %190

190:                                              ; preds = %845, %1
  %191 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i589 = getelementptr inbounds i8, i8* %0, i64 %191
  %192 = load i8, i8* %arrayidx.i589, align 1, !tbaa !6
  %.not = icmp eq i8 %192, 0
  br i1 %.not, label %195, label %193

193:                                              ; preds = %190
  %194 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i588 = add i64 %194, 1
  store i64 %add.i588, i64* %ptr, align 8, !tbaa !2
  br label %196

195:                                              ; preds = %190
  ret void

196:                                              ; preds = %199, %193
  %197 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i587 = getelementptr inbounds i8, i8* %0, i64 %197
  %198 = load i8, i8* %arrayidx.i587, align 1, !tbaa !6
  %.not1 = icmp eq i8 %198, 0
  br i1 %.not1, label %220, label %199

199:                                              ; preds = %196
  %200 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i586 = add i64 %200, 1
  store i64 %add.i586, i64* %ptr, align 8, !tbaa !2
  %201 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i585 = add i64 %201, 1
  store i64 %add.i585, i64* %ptr, align 8, !tbaa !2
  %202 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i584 = add i64 %202, 1
  store i64 %add.i584, i64* %ptr, align 8, !tbaa !2
  %203 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i583 = add i64 %203, 1
  store i64 %add.i583, i64* %ptr, align 8, !tbaa !2
  %204 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i582 = add i64 %204, 1
  store i64 %add.i582, i64* %ptr, align 8, !tbaa !2
  %205 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i581 = add i64 %205, 1
  store i64 %add.i581, i64* %ptr, align 8, !tbaa !2
  %206 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i579 = getelementptr inbounds i8, i8* %0, i64 %206
  %207 = load i8, i8* %arrayidx.i579, align 1, !tbaa !6
  %add.i580 = add i8 %207, 1
  store i8 %add.i580, i8* %arrayidx.i579, align 1, !tbaa !6
  %208 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i578 = add i64 %208, 1
  store i64 %add.i578, i64* %ptr, align 8, !tbaa !2
  %209 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i576 = getelementptr inbounds i8, i8* %0, i64 %209
  %210 = load i8, i8* %arrayidx.i576, align 1, !tbaa !6
  %add.i577 = add i8 %210, 1
  store i8 %add.i577, i8* %arrayidx.i576, align 1, !tbaa !6
  %211 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i575 = add i64 %211, -1
  store i64 %add.i575, i64* %ptr, align 8, !tbaa !2
  %212 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i574 = add i64 %212, -1
  store i64 %add.i574, i64* %ptr, align 8, !tbaa !2
  %213 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i573 = add i64 %213, -1
  store i64 %add.i573, i64* %ptr, align 8, !tbaa !2
  %214 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i572 = add i64 %214, -1
  store i64 %add.i572, i64* %ptr, align 8, !tbaa !2
  %215 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i571 = add i64 %215, -1
  store i64 %add.i571, i64* %ptr, align 8, !tbaa !2
  %216 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i570 = add i64 %216, -1
  store i64 %add.i570, i64* %ptr, align 8, !tbaa !2
  %217 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i569 = add i64 %217, -1
  store i64 %add.i569, i64* %ptr, align 8, !tbaa !2
  %218 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i567 = getelementptr inbounds i8, i8* %0, i64 %218
  %219 = load i8, i8* %arrayidx.i567, align 1, !tbaa !6
  %add.i568 = add i8 %219, -1
  store i8 %add.i568, i8* %arrayidx.i567, align 1, !tbaa !6
  br label %196

220:                                              ; preds = %196
  %221 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i566 = add i64 %221, 1
  store i64 %add.i566, i64* %ptr, align 8, !tbaa !2
  %222 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i565 = add i64 %222, 1
  store i64 %add.i565, i64* %ptr, align 8, !tbaa !2
  %223 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i564 = add i64 %223, 1
  store i64 %add.i564, i64* %ptr, align 8, !tbaa !2
  %224 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i563 = add i64 %224, 1
  store i64 %add.i563, i64* %ptr, align 8, !tbaa !2
  %225 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i562 = add i64 %225, 1
  store i64 %add.i562, i64* %ptr, align 8, !tbaa !2
  %226 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i561 = add i64 %226, 1
  store i64 %add.i561, i64* %ptr, align 8, !tbaa !2
  %227 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i560 = add i64 %227, 1
  store i64 %add.i560, i64* %ptr, align 8, !tbaa !2
  br label %228

228:                                              ; preds = %231, %220
  %229 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i559 = getelementptr inbounds i8, i8* %0, i64 %229
  %230 = load i8, i8* %arrayidx.i559, align 1, !tbaa !6
  %.not2 = icmp eq i8 %230, 0
  br i1 %.not2, label %.preheader.preheader, label %231

.preheader.preheader:                             ; preds = %228
  br label %.preheader

231:                                              ; preds = %228
  %232 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i558 = add i64 %232, -1
  store i64 %add.i558, i64* %ptr, align 8, !tbaa !2
  %233 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i557 = add i64 %233, -1
  store i64 %add.i557, i64* %ptr, align 8, !tbaa !2
  %234 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i556 = add i64 %234, -1
  store i64 %add.i556, i64* %ptr, align 8, !tbaa !2
  %235 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i555 = add i64 %235, -1
  store i64 %add.i555, i64* %ptr, align 8, !tbaa !2
  %236 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i554 = add i64 %236, -1
  store i64 %add.i554, i64* %ptr, align 8, !tbaa !2
  %237 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i553 = add i64 %237, -1
  store i64 %add.i553, i64* %ptr, align 8, !tbaa !2
  %238 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i552 = add i64 %238, -1
  store i64 %add.i552, i64* %ptr, align 8, !tbaa !2
  %239 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i550 = getelementptr inbounds i8, i8* %0, i64 %239
  %240 = load i8, i8* %arrayidx.i550, align 1, !tbaa !6
  %add.i551 = add i8 %240, 1
  store i8 %add.i551, i8* %arrayidx.i550, align 1, !tbaa !6
  %241 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i549 = add i64 %241, 1
  store i64 %add.i549, i64* %ptr, align 8, !tbaa !2
  %242 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i548 = add i64 %242, 1
  store i64 %add.i548, i64* %ptr, align 8, !tbaa !2
  %243 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i547 = add i64 %243, 1
  store i64 %add.i547, i64* %ptr, align 8, !tbaa !2
  %244 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i546 = add i64 %244, 1
  store i64 %add.i546, i64* %ptr, align 8, !tbaa !2
  %245 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i545 = add i64 %245, 1
  store i64 %add.i545, i64* %ptr, align 8, !tbaa !2
  %246 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i544 = add i64 %246, 1
  store i64 %add.i544, i64* %ptr, align 8, !tbaa !2
  %247 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i543 = add i64 %247, 1
  store i64 %add.i543, i64* %ptr, align 8, !tbaa !2
  %248 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i541 = getelementptr inbounds i8, i8* %0, i64 %248
  %249 = load i8, i8* %arrayidx.i541, align 1, !tbaa !6
  %add.i542 = add i8 %249, -1
  store i8 %add.i542, i8* %arrayidx.i541, align 1, !tbaa !6
  br label %228

.preheader:                                       ; preds = %.preheader.preheader, %447
  %250 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i540 = add i64 %250, -1
  store i64 %add.i540, i64* %ptr, align 8, !tbaa !2
  %251 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i539 = getelementptr inbounds i8, i8* %0, i64 %251
  %252 = load i8, i8* %arrayidx.i539, align 1, !tbaa !6
  %.not3 = icmp eq i8 %252, 0
  br i1 %.not3, label %275, label %253

253:                                              ; preds = %.preheader
  %254 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i538 = add i64 %254, 1
  store i64 %add.i538, i64* %ptr, align 8, !tbaa !2
  %255 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i536 = getelementptr inbounds i8, i8* %0, i64 %255
  %256 = load i8, i8* %arrayidx.i536, align 1, !tbaa !6
  %add.i537 = add i8 %256, 1
  store i8 %add.i537, i8* %arrayidx.i536, align 1, !tbaa !6
  %257 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i534 = getelementptr inbounds i8, i8* %0, i64 %257
  %258 = load i8, i8* %arrayidx.i534, align 1, !tbaa !6
  %add.i535 = add i8 %258, 1
  store i8 %add.i535, i8* %arrayidx.i534, align 1, !tbaa !6
  %259 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i532 = getelementptr inbounds i8, i8* %0, i64 %259
  %260 = load i8, i8* %arrayidx.i532, align 1, !tbaa !6
  %add.i533 = add i8 %260, 1
  store i8 %add.i533, i8* %arrayidx.i532, align 1, !tbaa !6
  %261 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i530 = getelementptr inbounds i8, i8* %0, i64 %261
  %262 = load i8, i8* %arrayidx.i530, align 1, !tbaa !6
  %add.i531 = add i8 %262, 1
  store i8 %add.i531, i8* %arrayidx.i530, align 1, !tbaa !6
  %263 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i528 = getelementptr inbounds i8, i8* %0, i64 %263
  %264 = load i8, i8* %arrayidx.i528, align 1, !tbaa !6
  %add.i529 = add i8 %264, 1
  store i8 %add.i529, i8* %arrayidx.i528, align 1, !tbaa !6
  %265 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i526 = getelementptr inbounds i8, i8* %0, i64 %265
  %266 = load i8, i8* %arrayidx.i526, align 1, !tbaa !6
  %add.i527 = add i8 %266, 1
  store i8 %add.i527, i8* %arrayidx.i526, align 1, !tbaa !6
  %267 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i524 = getelementptr inbounds i8, i8* %0, i64 %267
  %268 = load i8, i8* %arrayidx.i524, align 1, !tbaa !6
  %add.i525 = add i8 %268, 1
  store i8 %add.i525, i8* %arrayidx.i524, align 1, !tbaa !6
  %269 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i522 = getelementptr inbounds i8, i8* %0, i64 %269
  %270 = load i8, i8* %arrayidx.i522, align 1, !tbaa !6
  %add.i523 = add i8 %270, 1
  store i8 %add.i523, i8* %arrayidx.i522, align 1, !tbaa !6
  %271 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i520 = getelementptr inbounds i8, i8* %0, i64 %271
  %272 = load i8, i8* %arrayidx.i520, align 1, !tbaa !6
  %add.i521 = add i8 %272, 1
  store i8 %add.i521, i8* %arrayidx.i520, align 1, !tbaa !6
  %273 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i518 = getelementptr inbounds i8, i8* %0, i64 %273
  %274 = load i8, i8* %arrayidx.i518, align 1, !tbaa !6
  %add.i519 = add i8 %274, 1
  store i8 %add.i519, i8* %arrayidx.i518, align 1, !tbaa !6
  br label %281

275:                                              ; preds = %.preheader
  %276 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i517 = add i64 %276, 1
  store i64 %add.i517, i64* %ptr, align 8, !tbaa !2
  %277 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i516 = add i64 %277, 1
  store i64 %add.i516, i64* %ptr, align 8, !tbaa !2
  %278 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i515 = add i64 %278, 1
  store i64 %add.i515, i64* %ptr, align 8, !tbaa !2
  %279 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i514 = add i64 %279, 1
  store i64 %add.i514, i64* %ptr, align 8, !tbaa !2
  %280 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i513 = add i64 %280, 1
  store i64 %add.i513, i64* %ptr, align 8, !tbaa !2
  br label %.loopexit36

281:                                              ; preds = %354, %253
  %282 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i512 = getelementptr inbounds i8, i8* %0, i64 %282
  %283 = load i8, i8* %arrayidx.i512, align 1, !tbaa !6
  %.not16 = icmp eq i8 %283, 0
  br i1 %.not16, label %287, label %284

284:                                              ; preds = %281
  %285 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i510 = getelementptr inbounds i8, i8* %0, i64 %285
  %286 = load i8, i8* %arrayidx.i510, align 1, !tbaa !6
  %add.i511 = add i8 %286, -1
  store i8 %add.i511, i8* %arrayidx.i510, align 1, !tbaa !6
  br label %291

287:                                              ; preds = %281
  %288 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i509 = add i64 %288, 1
  store i64 %add.i509, i64* %ptr, align 8, !tbaa !2
  %289 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i508 = add i64 %289, 1
  store i64 %add.i508, i64* %ptr, align 8, !tbaa !2
  %290 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i507 = add i64 %290, 1
  store i64 %add.i507, i64* %ptr, align 8, !tbaa !2
  br label %380

291:                                              ; preds = %297, %284
  %292 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i506 = add i64 %292, -1
  store i64 %add.i506, i64* %ptr, align 8, !tbaa !2
  %293 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i504 = getelementptr inbounds i8, i8* %0, i64 %293
  %294 = load i8, i8* %arrayidx.i504, align 1, !tbaa !6
  %add.i505 = add i8 %294, -1
  store i8 %add.i505, i8* %arrayidx.i504, align 1, !tbaa !6
  %295 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i503 = getelementptr inbounds i8, i8* %0, i64 %295
  %296 = load i8, i8* %arrayidx.i503, align 1, !tbaa !6
  %.not24 = icmp eq i8 %296, 0
  br i1 %.not24, label %307, label %297

297:                                              ; preds = %291
  %298 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i502 = add i64 %298, 1
  store i64 %add.i502, i64* %ptr, align 8, !tbaa !2
  %299 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i501 = add i64 %299, 1
  store i64 %add.i501, i64* %ptr, align 8, !tbaa !2
  %300 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i499 = getelementptr inbounds i8, i8* %0, i64 %300
  %301 = load i8, i8* %arrayidx.i499, align 1, !tbaa !6
  %add.i500 = add i8 %301, 1
  store i8 %add.i500, i8* %arrayidx.i499, align 1, !tbaa !6
  %302 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i498 = add i64 %302, 1
  store i64 %add.i498, i64* %ptr, align 8, !tbaa !2
  %303 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i496 = getelementptr inbounds i8, i8* %0, i64 %303
  %304 = load i8, i8* %arrayidx.i496, align 1, !tbaa !6
  %add.i497 = add i8 %304, 1
  store i8 %add.i497, i8* %arrayidx.i496, align 1, !tbaa !6
  %305 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i495 = add i64 %305, -1
  store i64 %add.i495, i64* %ptr, align 8, !tbaa !2
  %306 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i494 = add i64 %306, -1
  store i64 %add.i494, i64* %ptr, align 8, !tbaa !2
  br label %291

307:                                              ; preds = %291
  %308 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i493 = add i64 %308, 1
  store i64 %add.i493, i64* %ptr, align 8, !tbaa !2
  %309 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i492 = add i64 %309, 1
  store i64 %add.i492, i64* %ptr, align 8, !tbaa !2
  %310 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i491 = add i64 %310, 1
  store i64 %add.i491, i64* %ptr, align 8, !tbaa !2
  br label %311

311:                                              ; preds = %314, %307
  %312 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i490 = getelementptr inbounds i8, i8* %0, i64 %312
  %313 = load i8, i8* %arrayidx.i490, align 1, !tbaa !6
  %.not25 = icmp eq i8 %313, 0
  br i1 %.not25, label %325, label %314

314:                                              ; preds = %311
  %315 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i489 = add i64 %315, -1
  store i64 %add.i489, i64* %ptr, align 8, !tbaa !2
  %316 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i488 = add i64 %316, -1
  store i64 %add.i488, i64* %ptr, align 8, !tbaa !2
  %317 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i487 = add i64 %317, -1
  store i64 %add.i487, i64* %ptr, align 8, !tbaa !2
  %318 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i485 = getelementptr inbounds i8, i8* %0, i64 %318
  %319 = load i8, i8* %arrayidx.i485, align 1, !tbaa !6
  %add.i486 = add i8 %319, 1
  store i8 %add.i486, i8* %arrayidx.i485, align 1, !tbaa !6
  %320 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i484 = add i64 %320, 1
  store i64 %add.i484, i64* %ptr, align 8, !tbaa !2
  %321 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i483 = add i64 %321, 1
  store i64 %add.i483, i64* %ptr, align 8, !tbaa !2
  %322 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i482 = add i64 %322, 1
  store i64 %add.i482, i64* %ptr, align 8, !tbaa !2
  %323 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i480 = getelementptr inbounds i8, i8* %0, i64 %323
  %324 = load i8, i8* %arrayidx.i480, align 1, !tbaa !6
  %add.i481 = add i8 %324, -1
  store i8 %add.i481, i8* %arrayidx.i480, align 1, !tbaa !6
  br label %311

325:                                              ; preds = %311
  %326 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i478 = getelementptr inbounds i8, i8* %0, i64 %326
  %327 = load i8, i8* %arrayidx.i478, align 1, !tbaa !6
  %add.i479 = add i8 %327, 1
  store i8 %add.i479, i8* %arrayidx.i478, align 1, !tbaa !6
  %328 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i477 = add i64 %328, -1
  store i64 %add.i477, i64* %ptr, align 8, !tbaa !2
  br label %.loopexit32

.loopexit32.loopexit:                             ; preds = %343
  br label %.loopexit32

.loopexit32:                                      ; preds = %.loopexit32.loopexit, %325
  %329 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i476 = getelementptr inbounds i8, i8* %0, i64 %329
  %330 = load i8, i8* %arrayidx.i476, align 1, !tbaa !6
  %.not26 = icmp eq i8 %330, 0
  br i1 %.not26, label %333, label %331

331:                                              ; preds = %.loopexit32
  %332 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i475 = add i64 %332, 1
  store i64 %add.i475, i64* %ptr, align 8, !tbaa !2
  br label %335

333:                                              ; preds = %.loopexit32
  %334 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i474 = add i64 %334, 1
  store i64 %add.i474, i64* %ptr, align 8, !tbaa !2
  br label %.loopexit

335:                                              ; preds = %338, %331
  %336 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i473 = getelementptr inbounds i8, i8* %0, i64 %336
  %337 = load i8, i8* %arrayidx.i473, align 1, !tbaa !6
  %.not30 = icmp eq i8 %337, 0
  br i1 %.not30, label %341, label %338

338:                                              ; preds = %335
  %339 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i471 = getelementptr inbounds i8, i8* %0, i64 %339
  %340 = load i8, i8* %arrayidx.i471, align 1, !tbaa !6
  %add.i472 = add i8 %340, -1
  store i8 %add.i472, i8* %arrayidx.i471, align 1, !tbaa !6
  br label %335

341:                                              ; preds = %335
  %342 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i470 = add i64 %342, -1
  store i64 %add.i470, i64* %ptr, align 8, !tbaa !2
  br label %343

343:                                              ; preds = %346, %341
  %344 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i469 = getelementptr inbounds i8, i8* %0, i64 %344
  %345 = load i8, i8* %arrayidx.i469, align 1, !tbaa !6
  %.not31 = icmp eq i8 %345, 0
  br i1 %.not31, label %.loopexit32.loopexit, label %346

346:                                              ; preds = %343
  %347 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i467 = getelementptr inbounds i8, i8* %0, i64 %347
  %348 = load i8, i8* %arrayidx.i467, align 1, !tbaa !6
  %add.i468 = add i8 %348, -1
  store i8 %add.i468, i8* %arrayidx.i467, align 1, !tbaa !6
  br label %343

.loopexit.loopexit:                               ; preds = %374
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %333
  %349 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i466 = getelementptr inbounds i8, i8* %0, i64 %349
  %350 = load i8, i8* %arrayidx.i466, align 1, !tbaa !6
  %.not27 = icmp eq i8 %350, 0
  br i1 %.not27, label %354, label %351

351:                                              ; preds = %.loopexit
  %352 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i465 = add i64 %352, -1
  store i64 %add.i465, i64* %ptr, align 8, !tbaa !2
  %353 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i464 = add i64 %353, -1
  store i64 %add.i464, i64* %ptr, align 8, !tbaa !2
  br label %357

354:                                              ; preds = %.loopexit
  %355 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i463 = add i64 %355, -1
  store i64 %add.i463, i64* %ptr, align 8, !tbaa !2
  %356 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i462 = add i64 %356, -1
  store i64 %add.i462, i64* %ptr, align 8, !tbaa !2
  br label %281

357:                                              ; preds = %360, %351
  %358 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i461 = getelementptr inbounds i8, i8* %0, i64 %358
  %359 = load i8, i8* %arrayidx.i461, align 1, !tbaa !6
  %.not28 = icmp eq i8 %359, 0
  br i1 %.not28, label %371, label %360

360:                                              ; preds = %357
  %361 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i460 = add i64 %361, 1
  store i64 %add.i460, i64* %ptr, align 8, !tbaa !2
  %362 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i459 = add i64 %362, 1
  store i64 %add.i459, i64* %ptr, align 8, !tbaa !2
  %363 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i458 = add i64 %363, 1
  store i64 %add.i458, i64* %ptr, align 8, !tbaa !2
  %364 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i456 = getelementptr inbounds i8, i8* %0, i64 %364
  %365 = load i8, i8* %arrayidx.i456, align 1, !tbaa !6
  %add.i457 = add i8 %365, 1
  store i8 %add.i457, i8* %arrayidx.i456, align 1, !tbaa !6
  %366 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i455 = add i64 %366, -1
  store i64 %add.i455, i64* %ptr, align 8, !tbaa !2
  %367 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i454 = add i64 %367, -1
  store i64 %add.i454, i64* %ptr, align 8, !tbaa !2
  %368 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i453 = add i64 %368, -1
  store i64 %add.i453, i64* %ptr, align 8, !tbaa !2
  %369 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i451 = getelementptr inbounds i8, i8* %0, i64 %369
  %370 = load i8, i8* %arrayidx.i451, align 1, !tbaa !6
  %add.i452 = add i8 %370, -1
  store i8 %add.i452, i8* %arrayidx.i451, align 1, !tbaa !6
  br label %357

371:                                              ; preds = %357
  %372 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i450 = add i64 %372, 1
  store i64 %add.i450, i64* %ptr, align 8, !tbaa !2
  %373 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i449 = add i64 %373, 1
  store i64 %add.i449, i64* %ptr, align 8, !tbaa !2
  br label %374

374:                                              ; preds = %377, %371
  %375 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i448 = getelementptr inbounds i8, i8* %0, i64 %375
  %376 = load i8, i8* %arrayidx.i448, align 1, !tbaa !6
  %.not29 = icmp eq i8 %376, 0
  br i1 %.not29, label %.loopexit.loopexit, label %377

377:                                              ; preds = %374
  %378 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i446 = getelementptr inbounds i8, i8* %0, i64 %378
  %379 = load i8, i8* %arrayidx.i446, align 1, !tbaa !6
  %add.i447 = add i8 %379, -1
  store i8 %add.i447, i8* %arrayidx.i446, align 1, !tbaa !6
  br label %374

380:                                              ; preds = %383, %287
  %381 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i445 = getelementptr inbounds i8, i8* %0, i64 %381
  %382 = load i8, i8* %arrayidx.i445, align 1, !tbaa !6
  %.not17 = icmp eq i8 %382, 0
  br i1 %.not17, label %396, label %383

383:                                              ; preds = %380
  %384 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i444 = add i64 %384, 1
  store i64 %add.i444, i64* %ptr, align 8, !tbaa !2
  %385 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i443 = add i64 %385, 1
  store i64 %add.i443, i64* %ptr, align 8, !tbaa !2
  %386 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i441 = getelementptr inbounds i8, i8* %0, i64 %386
  %387 = load i8, i8* %arrayidx.i441, align 1, !tbaa !6
  %add.i442 = add i8 %387, 1
  store i8 %add.i442, i8* %arrayidx.i441, align 1, !tbaa !6
  %388 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i440 = add i64 %388, 1
  store i64 %add.i440, i64* %ptr, align 8, !tbaa !2
  %389 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i438 = getelementptr inbounds i8, i8* %0, i64 %389
  %390 = load i8, i8* %arrayidx.i438, align 1, !tbaa !6
  %add.i439 = add i8 %390, 1
  store i8 %add.i439, i8* %arrayidx.i438, align 1, !tbaa !6
  %391 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i437 = add i64 %391, -1
  store i64 %add.i437, i64* %ptr, align 8, !tbaa !2
  %392 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i436 = add i64 %392, -1
  store i64 %add.i436, i64* %ptr, align 8, !tbaa !2
  %393 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i435 = add i64 %393, -1
  store i64 %add.i435, i64* %ptr, align 8, !tbaa !2
  %394 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i433 = getelementptr inbounds i8, i8* %0, i64 %394
  %395 = load i8, i8* %arrayidx.i433, align 1, !tbaa !6
  %add.i434 = add i8 %395, -1
  store i8 %add.i434, i8* %arrayidx.i433, align 1, !tbaa !6
  br label %380

396:                                              ; preds = %380
  %397 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i432 = add i64 %397, 1
  store i64 %add.i432, i64* %ptr, align 8, !tbaa !2
  %398 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i431 = add i64 %398, 1
  store i64 %add.i431, i64* %ptr, align 8, !tbaa !2
  %399 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i430 = add i64 %399, 1
  store i64 %add.i430, i64* %ptr, align 8, !tbaa !2
  br label %400

400:                                              ; preds = %403, %396
  %401 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i429 = getelementptr inbounds i8, i8* %0, i64 %401
  %402 = load i8, i8* %arrayidx.i429, align 1, !tbaa !6
  %.not18 = icmp eq i8 %402, 0
  br i1 %.not18, label %414, label %403

403:                                              ; preds = %400
  %404 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i428 = add i64 %404, -1
  store i64 %add.i428, i64* %ptr, align 8, !tbaa !2
  %405 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i427 = add i64 %405, -1
  store i64 %add.i427, i64* %ptr, align 8, !tbaa !2
  %406 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i426 = add i64 %406, -1
  store i64 %add.i426, i64* %ptr, align 8, !tbaa !2
  %407 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i424 = getelementptr inbounds i8, i8* %0, i64 %407
  %408 = load i8, i8* %arrayidx.i424, align 1, !tbaa !6
  %add.i425 = add i8 %408, 1
  store i8 %add.i425, i8* %arrayidx.i424, align 1, !tbaa !6
  %409 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i423 = add i64 %409, 1
  store i64 %add.i423, i64* %ptr, align 8, !tbaa !2
  %410 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i422 = add i64 %410, 1
  store i64 %add.i422, i64* %ptr, align 8, !tbaa !2
  %411 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i421 = add i64 %411, 1
  store i64 %add.i421, i64* %ptr, align 8, !tbaa !2
  %412 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i419 = getelementptr inbounds i8, i8* %0, i64 %412
  %413 = load i8, i8* %arrayidx.i419, align 1, !tbaa !6
  %add.i420 = add i8 %413, -1
  store i8 %add.i420, i8* %arrayidx.i419, align 1, !tbaa !6
  br label %400

414:                                              ; preds = %400
  %415 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i417 = getelementptr inbounds i8, i8* %0, i64 %415
  %416 = load i8, i8* %arrayidx.i417, align 1, !tbaa !6
  %add.i418 = add i8 %416, 1
  store i8 %add.i418, i8* %arrayidx.i417, align 1, !tbaa !6
  %417 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i416 = add i64 %417, -1
  store i64 %add.i416, i64* %ptr, align 8, !tbaa !2
  br label %.loopexit34

.loopexit34.loopexit:                             ; preds = %432
  br label %.loopexit34

.loopexit34:                                      ; preds = %.loopexit34.loopexit, %414
  %418 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i415 = getelementptr inbounds i8, i8* %0, i64 %418
  %419 = load i8, i8* %arrayidx.i415, align 1, !tbaa !6
  %.not19 = icmp eq i8 %419, 0
  br i1 %.not19, label %422, label %420

420:                                              ; preds = %.loopexit34
  %421 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i414 = add i64 %421, 1
  store i64 %add.i414, i64* %ptr, align 8, !tbaa !2
  br label %424

422:                                              ; preds = %.loopexit34
  %423 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i413 = add i64 %423, 1
  store i64 %add.i413, i64* %ptr, align 8, !tbaa !2
  br label %.loopexit33

424:                                              ; preds = %427, %420
  %425 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i412 = getelementptr inbounds i8, i8* %0, i64 %425
  %426 = load i8, i8* %arrayidx.i412, align 1, !tbaa !6
  %.not22 = icmp eq i8 %426, 0
  br i1 %.not22, label %430, label %427

427:                                              ; preds = %424
  %428 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i410 = getelementptr inbounds i8, i8* %0, i64 %428
  %429 = load i8, i8* %arrayidx.i410, align 1, !tbaa !6
  %add.i411 = add i8 %429, -1
  store i8 %add.i411, i8* %arrayidx.i410, align 1, !tbaa !6
  br label %424

430:                                              ; preds = %424
  %431 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i409 = add i64 %431, -1
  store i64 %add.i409, i64* %ptr, align 8, !tbaa !2
  br label %432

432:                                              ; preds = %435, %430
  %433 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i408 = getelementptr inbounds i8, i8* %0, i64 %433
  %434 = load i8, i8* %arrayidx.i408, align 1, !tbaa !6
  %.not23 = icmp eq i8 %434, 0
  br i1 %.not23, label %.loopexit34.loopexit, label %435

435:                                              ; preds = %432
  %436 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i406 = getelementptr inbounds i8, i8* %0, i64 %436
  %437 = load i8, i8* %arrayidx.i406, align 1, !tbaa !6
  %add.i407 = add i8 %437, -1
  store i8 %add.i407, i8* %arrayidx.i406, align 1, !tbaa !6
  br label %432

.loopexit33.loopexit:                             ; preds = %454
  br label %.loopexit33

.loopexit33:                                      ; preds = %.loopexit33.loopexit, %422
  %438 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i405 = getelementptr inbounds i8, i8* %0, i64 %438
  %439 = load i8, i8* %arrayidx.i405, align 1, !tbaa !6
  %.not20 = icmp eq i8 %439, 0
  br i1 %.not20, label %447, label %440

440:                                              ; preds = %.loopexit33
  %441 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i404 = add i64 %441, -1
  store i64 %add.i404, i64* %ptr, align 8, !tbaa !2
  %442 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i403 = add i64 %442, -1
  store i64 %add.i403, i64* %ptr, align 8, !tbaa !2
  %443 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i401 = getelementptr inbounds i8, i8* %0, i64 %443
  %444 = load i8, i8* %arrayidx.i401, align 1, !tbaa !6
  %add.i402 = add i8 %444, 1
  store i8 %add.i402, i8* %arrayidx.i401, align 1, !tbaa !6
  %445 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i400 = add i64 %445, 1
  store i64 %add.i400, i64* %ptr, align 8, !tbaa !2
  %446 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i399 = add i64 %446, 1
  store i64 %add.i399, i64* %ptr, align 8, !tbaa !2
  br label %454

447:                                              ; preds = %.loopexit33
  %448 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i398 = add i64 %448, -1
  store i64 %add.i398, i64* %ptr, align 8, !tbaa !2
  %449 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i397 = add i64 %449, -1
  store i64 %add.i397, i64* %ptr, align 8, !tbaa !2
  %450 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i396 = add i64 %450, -1
  store i64 %add.i396, i64* %ptr, align 8, !tbaa !2
  %451 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i395 = add i64 %451, -1
  store i64 %add.i395, i64* %ptr, align 8, !tbaa !2
  %452 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i394 = add i64 %452, -1
  store i64 %add.i394, i64* %ptr, align 8, !tbaa !2
  %453 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i393 = add i64 %453, -1
  store i64 %add.i393, i64* %ptr, align 8, !tbaa !2
  br label %.preheader

454:                                              ; preds = %457, %440
  %455 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i392 = getelementptr inbounds i8, i8* %0, i64 %455
  %456 = load i8, i8* %arrayidx.i392, align 1, !tbaa !6
  %.not21 = icmp eq i8 %456, 0
  br i1 %.not21, label %.loopexit33.loopexit, label %457

457:                                              ; preds = %454
  %458 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i390 = getelementptr inbounds i8, i8* %0, i64 %458
  %459 = load i8, i8* %arrayidx.i390, align 1, !tbaa !6
  %add.i391 = add i8 %459, -1
  store i8 %add.i391, i8* %arrayidx.i390, align 1, !tbaa !6
  br label %454

.loopexit36.loopexit:                             ; preds = %583
  br label %.loopexit36

.loopexit36:                                      ; preds = %.loopexit36.loopexit, %275
  %460 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i389 = getelementptr inbounds i8, i8* %0, i64 %460
  %461 = load i8, i8* %arrayidx.i389, align 1, !tbaa !6
  %.not4 = icmp eq i8 %461, 0
  br i1 %.not4, label %562, label %462

462:                                              ; preds = %.loopexit36
  %463 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i387 = getelementptr inbounds i8, i8* %0, i64 %463
  %464 = load i8, i8* %arrayidx.i387, align 1, !tbaa !6
  %add.i388 = add i8 %464, 1
  store i8 %add.i388, i8* %arrayidx.i387, align 1, !tbaa !6
  %465 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i385 = getelementptr inbounds i8, i8* %0, i64 %465
  %466 = load i8, i8* %arrayidx.i385, align 1, !tbaa !6
  %add.i386 = add i8 %466, 1
  store i8 %add.i386, i8* %arrayidx.i385, align 1, !tbaa !6
  %467 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i383 = getelementptr inbounds i8, i8* %0, i64 %467
  %468 = load i8, i8* %arrayidx.i383, align 1, !tbaa !6
  %add.i384 = add i8 %468, 1
  store i8 %add.i384, i8* %arrayidx.i383, align 1, !tbaa !6
  %469 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i381 = getelementptr inbounds i8, i8* %0, i64 %469
  %470 = load i8, i8* %arrayidx.i381, align 1, !tbaa !6
  %add.i382 = add i8 %470, 1
  store i8 %add.i382, i8* %arrayidx.i381, align 1, !tbaa !6
  %471 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i379 = getelementptr inbounds i8, i8* %0, i64 %471
  %472 = load i8, i8* %arrayidx.i379, align 1, !tbaa !6
  %add.i380 = add i8 %472, 1
  store i8 %add.i380, i8* %arrayidx.i379, align 1, !tbaa !6
  %473 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i377 = getelementptr inbounds i8, i8* %0, i64 %473
  %474 = load i8, i8* %arrayidx.i377, align 1, !tbaa !6
  %add.i378 = add i8 %474, 1
  store i8 %add.i378, i8* %arrayidx.i377, align 1, !tbaa !6
  %475 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i375 = getelementptr inbounds i8, i8* %0, i64 %475
  %476 = load i8, i8* %arrayidx.i375, align 1, !tbaa !6
  %add.i376 = add i8 %476, 1
  store i8 %add.i376, i8* %arrayidx.i375, align 1, !tbaa !6
  %477 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i373 = getelementptr inbounds i8, i8* %0, i64 %477
  %478 = load i8, i8* %arrayidx.i373, align 1, !tbaa !6
  %add.i374 = add i8 %478, 1
  store i8 %add.i374, i8* %arrayidx.i373, align 1, !tbaa !6
  %479 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i371 = getelementptr inbounds i8, i8* %0, i64 %479
  %480 = load i8, i8* %arrayidx.i371, align 1, !tbaa !6
  %add.i372 = add i8 %480, 1
  store i8 %add.i372, i8* %arrayidx.i371, align 1, !tbaa !6
  %481 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i369 = getelementptr inbounds i8, i8* %0, i64 %481
  %482 = load i8, i8* %arrayidx.i369, align 1, !tbaa !6
  %add.i370 = add i8 %482, 1
  store i8 %add.i370, i8* %arrayidx.i369, align 1, !tbaa !6
  %483 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i367 = getelementptr inbounds i8, i8* %0, i64 %483
  %484 = load i8, i8* %arrayidx.i367, align 1, !tbaa !6
  %add.i368 = add i8 %484, 1
  store i8 %add.i368, i8* %arrayidx.i367, align 1, !tbaa !6
  %485 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i365 = getelementptr inbounds i8, i8* %0, i64 %485
  %486 = load i8, i8* %arrayidx.i365, align 1, !tbaa !6
  %add.i366 = add i8 %486, 1
  store i8 %add.i366, i8* %arrayidx.i365, align 1, !tbaa !6
  %487 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i363 = getelementptr inbounds i8, i8* %0, i64 %487
  %488 = load i8, i8* %arrayidx.i363, align 1, !tbaa !6
  %add.i364 = add i8 %488, 1
  store i8 %add.i364, i8* %arrayidx.i363, align 1, !tbaa !6
  %489 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i361 = getelementptr inbounds i8, i8* %0, i64 %489
  %490 = load i8, i8* %arrayidx.i361, align 1, !tbaa !6
  %add.i362 = add i8 %490, 1
  store i8 %add.i362, i8* %arrayidx.i361, align 1, !tbaa !6
  %491 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i359 = getelementptr inbounds i8, i8* %0, i64 %491
  %492 = load i8, i8* %arrayidx.i359, align 1, !tbaa !6
  %add.i360 = add i8 %492, 1
  store i8 %add.i360, i8* %arrayidx.i359, align 1, !tbaa !6
  %493 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i357 = getelementptr inbounds i8, i8* %0, i64 %493
  %494 = load i8, i8* %arrayidx.i357, align 1, !tbaa !6
  %add.i358 = add i8 %494, 1
  store i8 %add.i358, i8* %arrayidx.i357, align 1, !tbaa !6
  %495 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i355 = getelementptr inbounds i8, i8* %0, i64 %495
  %496 = load i8, i8* %arrayidx.i355, align 1, !tbaa !6
  %add.i356 = add i8 %496, 1
  store i8 %add.i356, i8* %arrayidx.i355, align 1, !tbaa !6
  %497 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i353 = getelementptr inbounds i8, i8* %0, i64 %497
  %498 = load i8, i8* %arrayidx.i353, align 1, !tbaa !6
  %add.i354 = add i8 %498, 1
  store i8 %add.i354, i8* %arrayidx.i353, align 1, !tbaa !6
  %499 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i351 = getelementptr inbounds i8, i8* %0, i64 %499
  %500 = load i8, i8* %arrayidx.i351, align 1, !tbaa !6
  %add.i352 = add i8 %500, 1
  store i8 %add.i352, i8* %arrayidx.i351, align 1, !tbaa !6
  %501 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i349 = getelementptr inbounds i8, i8* %0, i64 %501
  %502 = load i8, i8* %arrayidx.i349, align 1, !tbaa !6
  %add.i350 = add i8 %502, 1
  store i8 %add.i350, i8* %arrayidx.i349, align 1, !tbaa !6
  %503 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i347 = getelementptr inbounds i8, i8* %0, i64 %503
  %504 = load i8, i8* %arrayidx.i347, align 1, !tbaa !6
  %add.i348 = add i8 %504, 1
  store i8 %add.i348, i8* %arrayidx.i347, align 1, !tbaa !6
  %505 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i345 = getelementptr inbounds i8, i8* %0, i64 %505
  %506 = load i8, i8* %arrayidx.i345, align 1, !tbaa !6
  %add.i346 = add i8 %506, 1
  store i8 %add.i346, i8* %arrayidx.i345, align 1, !tbaa !6
  %507 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i343 = getelementptr inbounds i8, i8* %0, i64 %507
  %508 = load i8, i8* %arrayidx.i343, align 1, !tbaa !6
  %add.i344 = add i8 %508, 1
  store i8 %add.i344, i8* %arrayidx.i343, align 1, !tbaa !6
  %509 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i341 = getelementptr inbounds i8, i8* %0, i64 %509
  %510 = load i8, i8* %arrayidx.i341, align 1, !tbaa !6
  %add.i342 = add i8 %510, 1
  store i8 %add.i342, i8* %arrayidx.i341, align 1, !tbaa !6
  %511 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i339 = getelementptr inbounds i8, i8* %0, i64 %511
  %512 = load i8, i8* %arrayidx.i339, align 1, !tbaa !6
  %add.i340 = add i8 %512, 1
  store i8 %add.i340, i8* %arrayidx.i339, align 1, !tbaa !6
  %513 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i337 = getelementptr inbounds i8, i8* %0, i64 %513
  %514 = load i8, i8* %arrayidx.i337, align 1, !tbaa !6
  %add.i338 = add i8 %514, 1
  store i8 %add.i338, i8* %arrayidx.i337, align 1, !tbaa !6
  %515 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i335 = getelementptr inbounds i8, i8* %0, i64 %515
  %516 = load i8, i8* %arrayidx.i335, align 1, !tbaa !6
  %add.i336 = add i8 %516, 1
  store i8 %add.i336, i8* %arrayidx.i335, align 1, !tbaa !6
  %517 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i333 = getelementptr inbounds i8, i8* %0, i64 %517
  %518 = load i8, i8* %arrayidx.i333, align 1, !tbaa !6
  %add.i334 = add i8 %518, 1
  store i8 %add.i334, i8* %arrayidx.i333, align 1, !tbaa !6
  %519 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i331 = getelementptr inbounds i8, i8* %0, i64 %519
  %520 = load i8, i8* %arrayidx.i331, align 1, !tbaa !6
  %add.i332 = add i8 %520, 1
  store i8 %add.i332, i8* %arrayidx.i331, align 1, !tbaa !6
  %521 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i329 = getelementptr inbounds i8, i8* %0, i64 %521
  %522 = load i8, i8* %arrayidx.i329, align 1, !tbaa !6
  %add.i330 = add i8 %522, 1
  store i8 %add.i330, i8* %arrayidx.i329, align 1, !tbaa !6
  %523 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i327 = getelementptr inbounds i8, i8* %0, i64 %523
  %524 = load i8, i8* %arrayidx.i327, align 1, !tbaa !6
  %add.i328 = add i8 %524, 1
  store i8 %add.i328, i8* %arrayidx.i327, align 1, !tbaa !6
  %525 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i325 = getelementptr inbounds i8, i8* %0, i64 %525
  %526 = load i8, i8* %arrayidx.i325, align 1, !tbaa !6
  %add.i326 = add i8 %526, 1
  store i8 %add.i326, i8* %arrayidx.i325, align 1, !tbaa !6
  %527 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i323 = getelementptr inbounds i8, i8* %0, i64 %527
  %528 = load i8, i8* %arrayidx.i323, align 1, !tbaa !6
  %add.i324 = add i8 %528, 1
  store i8 %add.i324, i8* %arrayidx.i323, align 1, !tbaa !6
  %529 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i321 = getelementptr inbounds i8, i8* %0, i64 %529
  %530 = load i8, i8* %arrayidx.i321, align 1, !tbaa !6
  %add.i322 = add i8 %530, 1
  store i8 %add.i322, i8* %arrayidx.i321, align 1, !tbaa !6
  %531 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i319 = getelementptr inbounds i8, i8* %0, i64 %531
  %532 = load i8, i8* %arrayidx.i319, align 1, !tbaa !6
  %add.i320 = add i8 %532, 1
  store i8 %add.i320, i8* %arrayidx.i319, align 1, !tbaa !6
  %533 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i317 = getelementptr inbounds i8, i8* %0, i64 %533
  %534 = load i8, i8* %arrayidx.i317, align 1, !tbaa !6
  %add.i318 = add i8 %534, 1
  store i8 %add.i318, i8* %arrayidx.i317, align 1, !tbaa !6
  %535 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i315 = getelementptr inbounds i8, i8* %0, i64 %535
  %536 = load i8, i8* %arrayidx.i315, align 1, !tbaa !6
  %add.i316 = add i8 %536, 1
  store i8 %add.i316, i8* %arrayidx.i315, align 1, !tbaa !6
  %537 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i313 = getelementptr inbounds i8, i8* %0, i64 %537
  %538 = load i8, i8* %arrayidx.i313, align 1, !tbaa !6
  %add.i314 = add i8 %538, 1
  store i8 %add.i314, i8* %arrayidx.i313, align 1, !tbaa !6
  %539 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i311 = getelementptr inbounds i8, i8* %0, i64 %539
  %540 = load i8, i8* %arrayidx.i311, align 1, !tbaa !6
  %add.i312 = add i8 %540, 1
  store i8 %add.i312, i8* %arrayidx.i311, align 1, !tbaa !6
  %541 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i309 = getelementptr inbounds i8, i8* %0, i64 %541
  %542 = load i8, i8* %arrayidx.i309, align 1, !tbaa !6
  %add.i310 = add i8 %542, 1
  store i8 %add.i310, i8* %arrayidx.i309, align 1, !tbaa !6
  %543 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i307 = getelementptr inbounds i8, i8* %0, i64 %543
  %544 = load i8, i8* %arrayidx.i307, align 1, !tbaa !6
  %add.i308 = add i8 %544, 1
  store i8 %add.i308, i8* %arrayidx.i307, align 1, !tbaa !6
  %545 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i305 = getelementptr inbounds i8, i8* %0, i64 %545
  %546 = load i8, i8* %arrayidx.i305, align 1, !tbaa !6
  %add.i306 = add i8 %546, 1
  store i8 %add.i306, i8* %arrayidx.i305, align 1, !tbaa !6
  %547 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i303 = getelementptr inbounds i8, i8* %0, i64 %547
  %548 = load i8, i8* %arrayidx.i303, align 1, !tbaa !6
  %add.i304 = add i8 %548, 1
  store i8 %add.i304, i8* %arrayidx.i303, align 1, !tbaa !6
  %549 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i301 = getelementptr inbounds i8, i8* %0, i64 %549
  %550 = load i8, i8* %arrayidx.i301, align 1, !tbaa !6
  %add.i302 = add i8 %550, 1
  store i8 %add.i302, i8* %arrayidx.i301, align 1, !tbaa !6
  %551 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i299 = getelementptr inbounds i8, i8* %0, i64 %551
  %552 = load i8, i8* %arrayidx.i299, align 1, !tbaa !6
  %add.i300 = add i8 %552, 1
  store i8 %add.i300, i8* %arrayidx.i299, align 1, !tbaa !6
  %553 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i297 = getelementptr inbounds i8, i8* %0, i64 %553
  %554 = load i8, i8* %arrayidx.i297, align 1, !tbaa !6
  %add.i298 = add i8 %554, 1
  store i8 %add.i298, i8* %arrayidx.i297, align 1, !tbaa !6
  %555 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i295 = getelementptr inbounds i8, i8* %0, i64 %555
  %556 = load i8, i8* %arrayidx.i295, align 1, !tbaa !6
  %add.i296 = add i8 %556, 1
  store i8 %add.i296, i8* %arrayidx.i295, align 1, !tbaa !6
  %557 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i293 = getelementptr inbounds i8, i8* %0, i64 %557
  %558 = load i8, i8* %arrayidx.i293, align 1, !tbaa !6
  %add.i294 = add i8 %558, 1
  store i8 %add.i294, i8* %arrayidx.i293, align 1, !tbaa !6
  %559 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i288 = getelementptr inbounds i8, i8* %0, i64 %559
  %560 = load i8, i8* %arrayidx.i288, align 1, !tbaa !6
  %conv.i289 = zext i8 %560 to i32
  %561 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i290 = call i32 @putc(i32 %conv.i289, %struct._IO_FILE* %561) #9
  br label %583

562:                                              ; preds = %.loopexit36
  %563 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i286 = getelementptr inbounds i8, i8* %0, i64 %563
  %564 = load i8, i8* %arrayidx.i286, align 1, !tbaa !6
  %add.i287 = add i8 %564, 1
  store i8 %add.i287, i8* %arrayidx.i286, align 1, !tbaa !6
  %565 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i284 = getelementptr inbounds i8, i8* %0, i64 %565
  %566 = load i8, i8* %arrayidx.i284, align 1, !tbaa !6
  %add.i285 = add i8 %566, 1
  store i8 %add.i285, i8* %arrayidx.i284, align 1, !tbaa !6
  %567 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i282 = getelementptr inbounds i8, i8* %0, i64 %567
  %568 = load i8, i8* %arrayidx.i282, align 1, !tbaa !6
  %add.i283 = add i8 %568, 1
  store i8 %add.i283, i8* %arrayidx.i282, align 1, !tbaa !6
  %569 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i280 = getelementptr inbounds i8, i8* %0, i64 %569
  %570 = load i8, i8* %arrayidx.i280, align 1, !tbaa !6
  %add.i281 = add i8 %570, 1
  store i8 %add.i281, i8* %arrayidx.i280, align 1, !tbaa !6
  %571 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i278 = getelementptr inbounds i8, i8* %0, i64 %571
  %572 = load i8, i8* %arrayidx.i278, align 1, !tbaa !6
  %add.i279 = add i8 %572, 1
  store i8 %add.i279, i8* %arrayidx.i278, align 1, !tbaa !6
  %573 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i276 = getelementptr inbounds i8, i8* %0, i64 %573
  %574 = load i8, i8* %arrayidx.i276, align 1, !tbaa !6
  %add.i277 = add i8 %574, 1
  store i8 %add.i277, i8* %arrayidx.i276, align 1, !tbaa !6
  %575 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i274 = getelementptr inbounds i8, i8* %0, i64 %575
  %576 = load i8, i8* %arrayidx.i274, align 1, !tbaa !6
  %add.i275 = add i8 %576, 1
  store i8 %add.i275, i8* %arrayidx.i274, align 1, !tbaa !6
  %577 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i272 = getelementptr inbounds i8, i8* %0, i64 %577
  %578 = load i8, i8* %arrayidx.i272, align 1, !tbaa !6
  %add.i273 = add i8 %578, 1
  store i8 %add.i273, i8* %arrayidx.i272, align 1, !tbaa !6
  %579 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i270 = getelementptr inbounds i8, i8* %0, i64 %579
  %580 = load i8, i8* %arrayidx.i270, align 1, !tbaa !6
  %add.i271 = add i8 %580, 1
  store i8 %add.i271, i8* %arrayidx.i270, align 1, !tbaa !6
  %581 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i268 = getelementptr inbounds i8, i8* %0, i64 %581
  %582 = load i8, i8* %arrayidx.i268, align 1, !tbaa !6
  %add.i269 = add i8 %582, 1
  store i8 %add.i269, i8* %arrayidx.i268, align 1, !tbaa !6
  br label %589

583:                                              ; preds = %586, %462
  %584 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i267 = getelementptr inbounds i8, i8* %0, i64 %584
  %585 = load i8, i8* %arrayidx.i267, align 1, !tbaa !6
  %.not15 = icmp eq i8 %585, 0
  br i1 %.not15, label %.loopexit36.loopexit, label %586

586:                                              ; preds = %583
  %587 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i265 = getelementptr inbounds i8, i8* %0, i64 %587
  %588 = load i8, i8* %arrayidx.i265, align 1, !tbaa !6
  %add.i266 = add i8 %588, -1
  store i8 %add.i266, i8* %arrayidx.i265, align 1, !tbaa !6
  br label %583

589:                                              ; preds = %593, %562
  %590 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i264 = add i64 %590, -1
  store i64 %add.i264, i64* %ptr, align 8, !tbaa !2
  %591 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i263 = getelementptr inbounds i8, i8* %0, i64 %591
  %592 = load i8, i8* %arrayidx.i263, align 1, !tbaa !6
  %.not5 = icmp eq i8 %592, 0
  br i1 %.not5, label %599, label %593

593:                                              ; preds = %589
  %594 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i261 = getelementptr inbounds i8, i8* %0, i64 %594
  %595 = load i8, i8* %arrayidx.i261, align 1, !tbaa !6
  %add.i262 = add i8 %595, -1
  store i8 %add.i262, i8* %arrayidx.i261, align 1, !tbaa !6
  %596 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i260 = add i64 %596, 1
  store i64 %add.i260, i64* %ptr, align 8, !tbaa !2
  %597 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i258 = getelementptr inbounds i8, i8* %0, i64 %597
  %598 = load i8, i8* %arrayidx.i258, align 1, !tbaa !6
  %add.i259 = add i8 %598, -1
  store i8 %add.i259, i8* %arrayidx.i258, align 1, !tbaa !6
  br label %589

599:                                              ; preds = %589
  %600 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i257 = add i64 %600, 1
  store i64 %add.i257, i64* %ptr, align 8, !tbaa !2
  %601 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i255 = getelementptr inbounds i8, i8* %0, i64 %601
  %602 = load i8, i8* %arrayidx.i255, align 1, !tbaa !6
  %add.i256 = add i8 %602, 1
  store i8 %add.i256, i8* %arrayidx.i255, align 1, !tbaa !6
  %603 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i253 = getelementptr inbounds i8, i8* %0, i64 %603
  %604 = load i8, i8* %arrayidx.i253, align 1, !tbaa !6
  %add.i254 = add i8 %604, 1
  store i8 %add.i254, i8* %arrayidx.i253, align 1, !tbaa !6
  %605 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i251 = getelementptr inbounds i8, i8* %0, i64 %605
  %606 = load i8, i8* %arrayidx.i251, align 1, !tbaa !6
  %add.i252 = add i8 %606, 1
  store i8 %add.i252, i8* %arrayidx.i251, align 1, !tbaa !6
  %607 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i249 = getelementptr inbounds i8, i8* %0, i64 %607
  %608 = load i8, i8* %arrayidx.i249, align 1, !tbaa !6
  %add.i250 = add i8 %608, 1
  store i8 %add.i250, i8* %arrayidx.i249, align 1, !tbaa !6
  %609 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i247 = getelementptr inbounds i8, i8* %0, i64 %609
  %610 = load i8, i8* %arrayidx.i247, align 1, !tbaa !6
  %add.i248 = add i8 %610, 1
  store i8 %add.i248, i8* %arrayidx.i247, align 1, !tbaa !6
  %611 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i245 = getelementptr inbounds i8, i8* %0, i64 %611
  %612 = load i8, i8* %arrayidx.i245, align 1, !tbaa !6
  %add.i246 = add i8 %612, 1
  store i8 %add.i246, i8* %arrayidx.i245, align 1, !tbaa !6
  %613 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i243 = getelementptr inbounds i8, i8* %0, i64 %613
  %614 = load i8, i8* %arrayidx.i243, align 1, !tbaa !6
  %add.i244 = add i8 %614, 1
  store i8 %add.i244, i8* %arrayidx.i243, align 1, !tbaa !6
  %615 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i241 = getelementptr inbounds i8, i8* %0, i64 %615
  %616 = load i8, i8* %arrayidx.i241, align 1, !tbaa !6
  %add.i242 = add i8 %616, 1
  store i8 %add.i242, i8* %arrayidx.i241, align 1, !tbaa !6
  %617 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i239 = getelementptr inbounds i8, i8* %0, i64 %617
  %618 = load i8, i8* %arrayidx.i239, align 1, !tbaa !6
  %add.i240 = add i8 %618, 1
  store i8 %add.i240, i8* %arrayidx.i239, align 1, !tbaa !6
  %619 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i237 = getelementptr inbounds i8, i8* %0, i64 %619
  %620 = load i8, i8* %arrayidx.i237, align 1, !tbaa !6
  %add.i238 = add i8 %620, 1
  store i8 %add.i238, i8* %arrayidx.i237, align 1, !tbaa !6
  %621 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i235 = getelementptr inbounds i8, i8* %0, i64 %621
  %622 = load i8, i8* %arrayidx.i235, align 1, !tbaa !6
  %add.i236 = add i8 %622, 1
  store i8 %add.i236, i8* %arrayidx.i235, align 1, !tbaa !6
  %623 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i233 = getelementptr inbounds i8, i8* %0, i64 %623
  %624 = load i8, i8* %arrayidx.i233, align 1, !tbaa !6
  %add.i234 = add i8 %624, 1
  store i8 %add.i234, i8* %arrayidx.i233, align 1, !tbaa !6
  %625 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i231 = getelementptr inbounds i8, i8* %0, i64 %625
  %626 = load i8, i8* %arrayidx.i231, align 1, !tbaa !6
  %add.i232 = add i8 %626, 1
  store i8 %add.i232, i8* %arrayidx.i231, align 1, !tbaa !6
  %627 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i229 = getelementptr inbounds i8, i8* %0, i64 %627
  %628 = load i8, i8* %arrayidx.i229, align 1, !tbaa !6
  %add.i230 = add i8 %628, 1
  store i8 %add.i230, i8* %arrayidx.i229, align 1, !tbaa !6
  %629 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i227 = getelementptr inbounds i8, i8* %0, i64 %629
  %630 = load i8, i8* %arrayidx.i227, align 1, !tbaa !6
  %add.i228 = add i8 %630, 1
  store i8 %add.i228, i8* %arrayidx.i227, align 1, !tbaa !6
  %631 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i225 = getelementptr inbounds i8, i8* %0, i64 %631
  %632 = load i8, i8* %arrayidx.i225, align 1, !tbaa !6
  %add.i226 = add i8 %632, 1
  store i8 %add.i226, i8* %arrayidx.i225, align 1, !tbaa !6
  %633 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i223 = getelementptr inbounds i8, i8* %0, i64 %633
  %634 = load i8, i8* %arrayidx.i223, align 1, !tbaa !6
  %add.i224 = add i8 %634, 1
  store i8 %add.i224, i8* %arrayidx.i223, align 1, !tbaa !6
  %635 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i221 = getelementptr inbounds i8, i8* %0, i64 %635
  %636 = load i8, i8* %arrayidx.i221, align 1, !tbaa !6
  %add.i222 = add i8 %636, 1
  store i8 %add.i222, i8* %arrayidx.i221, align 1, !tbaa !6
  %637 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i219 = getelementptr inbounds i8, i8* %0, i64 %637
  %638 = load i8, i8* %arrayidx.i219, align 1, !tbaa !6
  %add.i220 = add i8 %638, 1
  store i8 %add.i220, i8* %arrayidx.i219, align 1, !tbaa !6
  %639 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i217 = getelementptr inbounds i8, i8* %0, i64 %639
  %640 = load i8, i8* %arrayidx.i217, align 1, !tbaa !6
  %add.i218 = add i8 %640, 1
  store i8 %add.i218, i8* %arrayidx.i217, align 1, !tbaa !6
  %641 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i215 = getelementptr inbounds i8, i8* %0, i64 %641
  %642 = load i8, i8* %arrayidx.i215, align 1, !tbaa !6
  %add.i216 = add i8 %642, 1
  store i8 %add.i216, i8* %arrayidx.i215, align 1, !tbaa !6
  %643 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i213 = getelementptr inbounds i8, i8* %0, i64 %643
  %644 = load i8, i8* %arrayidx.i213, align 1, !tbaa !6
  %add.i214 = add i8 %644, 1
  store i8 %add.i214, i8* %arrayidx.i213, align 1, !tbaa !6
  %645 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i211 = getelementptr inbounds i8, i8* %0, i64 %645
  %646 = load i8, i8* %arrayidx.i211, align 1, !tbaa !6
  %add.i212 = add i8 %646, 1
  store i8 %add.i212, i8* %arrayidx.i211, align 1, !tbaa !6
  %647 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i209 = getelementptr inbounds i8, i8* %0, i64 %647
  %648 = load i8, i8* %arrayidx.i209, align 1, !tbaa !6
  %add.i210 = add i8 %648, 1
  store i8 %add.i210, i8* %arrayidx.i209, align 1, !tbaa !6
  %649 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i207 = getelementptr inbounds i8, i8* %0, i64 %649
  %650 = load i8, i8* %arrayidx.i207, align 1, !tbaa !6
  %add.i208 = add i8 %650, 1
  store i8 %add.i208, i8* %arrayidx.i207, align 1, !tbaa !6
  %651 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i205 = getelementptr inbounds i8, i8* %0, i64 %651
  %652 = load i8, i8* %arrayidx.i205, align 1, !tbaa !6
  %add.i206 = add i8 %652, 1
  store i8 %add.i206, i8* %arrayidx.i205, align 1, !tbaa !6
  %653 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i203 = getelementptr inbounds i8, i8* %0, i64 %653
  %654 = load i8, i8* %arrayidx.i203, align 1, !tbaa !6
  %add.i204 = add i8 %654, 1
  store i8 %add.i204, i8* %arrayidx.i203, align 1, !tbaa !6
  %655 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i201 = getelementptr inbounds i8, i8* %0, i64 %655
  %656 = load i8, i8* %arrayidx.i201, align 1, !tbaa !6
  %add.i202 = add i8 %656, 1
  store i8 %add.i202, i8* %arrayidx.i201, align 1, !tbaa !6
  %657 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i199 = getelementptr inbounds i8, i8* %0, i64 %657
  %658 = load i8, i8* %arrayidx.i199, align 1, !tbaa !6
  %add.i200 = add i8 %658, 1
  store i8 %add.i200, i8* %arrayidx.i199, align 1, !tbaa !6
  %659 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i197 = getelementptr inbounds i8, i8* %0, i64 %659
  %660 = load i8, i8* %arrayidx.i197, align 1, !tbaa !6
  %add.i198 = add i8 %660, 1
  store i8 %add.i198, i8* %arrayidx.i197, align 1, !tbaa !6
  %661 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i195 = getelementptr inbounds i8, i8* %0, i64 %661
  %662 = load i8, i8* %arrayidx.i195, align 1, !tbaa !6
  %add.i196 = add i8 %662, 1
  store i8 %add.i196, i8* %arrayidx.i195, align 1, !tbaa !6
  %663 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i193 = getelementptr inbounds i8, i8* %0, i64 %663
  %664 = load i8, i8* %arrayidx.i193, align 1, !tbaa !6
  %add.i194 = add i8 %664, 1
  store i8 %add.i194, i8* %arrayidx.i193, align 1, !tbaa !6
  %665 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i191 = getelementptr inbounds i8, i8* %0, i64 %665
  %666 = load i8, i8* %arrayidx.i191, align 1, !tbaa !6
  %add.i192 = add i8 %666, 1
  store i8 %add.i192, i8* %arrayidx.i191, align 1, !tbaa !6
  %667 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i189 = getelementptr inbounds i8, i8* %0, i64 %667
  %668 = load i8, i8* %arrayidx.i189, align 1, !tbaa !6
  %add.i190 = add i8 %668, 1
  store i8 %add.i190, i8* %arrayidx.i189, align 1, !tbaa !6
  %669 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i187 = getelementptr inbounds i8, i8* %0, i64 %669
  %670 = load i8, i8* %arrayidx.i187, align 1, !tbaa !6
  %add.i188 = add i8 %670, 1
  store i8 %add.i188, i8* %arrayidx.i187, align 1, !tbaa !6
  %671 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i185 = getelementptr inbounds i8, i8* %0, i64 %671
  %672 = load i8, i8* %arrayidx.i185, align 1, !tbaa !6
  %add.i186 = add i8 %672, 1
  store i8 %add.i186, i8* %arrayidx.i185, align 1, !tbaa !6
  %673 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i183 = getelementptr inbounds i8, i8* %0, i64 %673
  %674 = load i8, i8* %arrayidx.i183, align 1, !tbaa !6
  %add.i184 = add i8 %674, 1
  store i8 %add.i184, i8* %arrayidx.i183, align 1, !tbaa !6
  %675 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i181 = getelementptr inbounds i8, i8* %0, i64 %675
  %676 = load i8, i8* %arrayidx.i181, align 1, !tbaa !6
  %add.i182 = add i8 %676, 1
  store i8 %add.i182, i8* %arrayidx.i181, align 1, !tbaa !6
  %677 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i179 = getelementptr inbounds i8, i8* %0, i64 %677
  %678 = load i8, i8* %arrayidx.i179, align 1, !tbaa !6
  %add.i180 = add i8 %678, 1
  store i8 %add.i180, i8* %arrayidx.i179, align 1, !tbaa !6
  %679 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i177 = getelementptr inbounds i8, i8* %0, i64 %679
  %680 = load i8, i8* %arrayidx.i177, align 1, !tbaa !6
  %add.i178 = add i8 %680, 1
  store i8 %add.i178, i8* %arrayidx.i177, align 1, !tbaa !6
  %681 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i175 = getelementptr inbounds i8, i8* %0, i64 %681
  %682 = load i8, i8* %arrayidx.i175, align 1, !tbaa !6
  %add.i176 = add i8 %682, 1
  store i8 %add.i176, i8* %arrayidx.i175, align 1, !tbaa !6
  %683 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i173 = getelementptr inbounds i8, i8* %0, i64 %683
  %684 = load i8, i8* %arrayidx.i173, align 1, !tbaa !6
  %add.i174 = add i8 %684, 1
  store i8 %add.i174, i8* %arrayidx.i173, align 1, !tbaa !6
  %685 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i171 = getelementptr inbounds i8, i8* %0, i64 %685
  %686 = load i8, i8* %arrayidx.i171, align 1, !tbaa !6
  %add.i172 = add i8 %686, 1
  store i8 %add.i172, i8* %arrayidx.i171, align 1, !tbaa !6
  %687 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i169 = getelementptr inbounds i8, i8* %0, i64 %687
  %688 = load i8, i8* %arrayidx.i169, align 1, !tbaa !6
  %add.i170 = add i8 %688, 1
  store i8 %add.i170, i8* %arrayidx.i169, align 1, !tbaa !6
  %689 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i167 = getelementptr inbounds i8, i8* %0, i64 %689
  %690 = load i8, i8* %arrayidx.i167, align 1, !tbaa !6
  %add.i168 = add i8 %690, 1
  store i8 %add.i168, i8* %arrayidx.i167, align 1, !tbaa !6
  %691 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i165 = getelementptr inbounds i8, i8* %0, i64 %691
  %692 = load i8, i8* %arrayidx.i165, align 1, !tbaa !6
  %add.i166 = add i8 %692, 1
  store i8 %add.i166, i8* %arrayidx.i165, align 1, !tbaa !6
  %693 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i163 = getelementptr inbounds i8, i8* %0, i64 %693
  %694 = load i8, i8* %arrayidx.i163, align 1, !tbaa !6
  %add.i164 = add i8 %694, 1
  store i8 %add.i164, i8* %arrayidx.i163, align 1, !tbaa !6
  %695 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i161 = getelementptr inbounds i8, i8* %0, i64 %695
  %696 = load i8, i8* %arrayidx.i161, align 1, !tbaa !6
  %add.i162 = add i8 %696, 1
  store i8 %add.i162, i8* %arrayidx.i161, align 1, !tbaa !6
  %697 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i156 = getelementptr inbounds i8, i8* %0, i64 %697
  %698 = load i8, i8* %arrayidx.i156, align 1, !tbaa !6
  %conv.i157 = zext i8 %698 to i32
  %699 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i158 = call i32 @putc(i32 %conv.i157, %struct._IO_FILE* %699) #9
  br label %700

700:                                              ; preds = %703, %599
  %701 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i155 = getelementptr inbounds i8, i8* %0, i64 %701
  %702 = load i8, i8* %arrayidx.i155, align 1, !tbaa !6
  %.not6 = icmp eq i8 %702, 0
  br i1 %.not6, label %706, label %703

703:                                              ; preds = %700
  %704 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i153 = getelementptr inbounds i8, i8* %0, i64 %704
  %705 = load i8, i8* %arrayidx.i153, align 1, !tbaa !6
  %add.i154 = add i8 %705, -1
  store i8 %add.i154, i8* %arrayidx.i153, align 1, !tbaa !6
  br label %700

706:                                              ; preds = %700
  %707 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i152 = add i64 %707, -1
  store i64 %add.i152, i64* %ptr, align 8, !tbaa !2
  %708 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i151 = add i64 %708, -1
  store i64 %add.i151, i64* %ptr, align 8, !tbaa !2
  %709 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i150 = add i64 %709, -1
  store i64 %add.i150, i64* %ptr, align 8, !tbaa !2
  %710 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i149 = add i64 %710, -1
  store i64 %add.i149, i64* %ptr, align 8, !tbaa !2
  %711 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i148 = add i64 %711, -1
  store i64 %add.i148, i64* %ptr, align 8, !tbaa !2
  %712 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i147 = add i64 %712, -1
  store i64 %add.i147, i64* %ptr, align 8, !tbaa !2
  %713 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i146 = add i64 %713, -1
  store i64 %add.i146, i64* %ptr, align 8, !tbaa !2
  %714 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i145 = add i64 %714, -1
  store i64 %add.i145, i64* %ptr, align 8, !tbaa !2
  %715 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i144 = add i64 %715, -1
  store i64 %add.i144, i64* %ptr, align 8, !tbaa !2
  %716 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i143 = add i64 %716, -1
  store i64 %add.i143, i64* %ptr, align 8, !tbaa !2
  %717 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i142 = add i64 %717, -1
  store i64 %add.i142, i64* %ptr, align 8, !tbaa !2
  %718 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i141 = add i64 %718, -1
  store i64 %add.i141, i64* %ptr, align 8, !tbaa !2
  br label %719

719:                                              ; preds = %722, %706
  %720 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i140 = getelementptr inbounds i8, i8* %0, i64 %720
  %721 = load i8, i8* %arrayidx.i140, align 1, !tbaa !6
  %.not7 = icmp eq i8 %721, 0
  br i1 %.not7, label %737, label %722

722:                                              ; preds = %719
  %723 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i139 = add i64 %723, 1
  store i64 %add.i139, i64* %ptr, align 8, !tbaa !2
  %724 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i138 = add i64 %724, 1
  store i64 %add.i138, i64* %ptr, align 8, !tbaa !2
  %725 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i137 = add i64 %725, 1
  store i64 %add.i137, i64* %ptr, align 8, !tbaa !2
  %726 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i135 = getelementptr inbounds i8, i8* %0, i64 %726
  %727 = load i8, i8* %arrayidx.i135, align 1, !tbaa !6
  %add.i136 = add i8 %727, 1
  store i8 %add.i136, i8* %arrayidx.i135, align 1, !tbaa !6
  %728 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i134 = add i64 %728, 1
  store i64 %add.i134, i64* %ptr, align 8, !tbaa !2
  %729 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i132 = getelementptr inbounds i8, i8* %0, i64 %729
  %730 = load i8, i8* %arrayidx.i132, align 1, !tbaa !6
  %add.i133 = add i8 %730, 1
  store i8 %add.i133, i8* %arrayidx.i132, align 1, !tbaa !6
  %731 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i131 = add i64 %731, -1
  store i64 %add.i131, i64* %ptr, align 8, !tbaa !2
  %732 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i130 = add i64 %732, -1
  store i64 %add.i130, i64* %ptr, align 8, !tbaa !2
  %733 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i129 = add i64 %733, -1
  store i64 %add.i129, i64* %ptr, align 8, !tbaa !2
  %734 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i128 = add i64 %734, -1
  store i64 %add.i128, i64* %ptr, align 8, !tbaa !2
  %735 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i126 = getelementptr inbounds i8, i8* %0, i64 %735
  %736 = load i8, i8* %arrayidx.i126, align 1, !tbaa !6
  %add.i127 = add i8 %736, -1
  store i8 %add.i127, i8* %arrayidx.i126, align 1, !tbaa !6
  br label %719

737:                                              ; preds = %719
  %738 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i125 = add i64 %738, 1
  store i64 %add.i125, i64* %ptr, align 8, !tbaa !2
  %739 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i124 = add i64 %739, 1
  store i64 %add.i124, i64* %ptr, align 8, !tbaa !2
  %740 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i123 = add i64 %740, 1
  store i64 %add.i123, i64* %ptr, align 8, !tbaa !2
  %741 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i122 = add i64 %741, 1
  store i64 %add.i122, i64* %ptr, align 8, !tbaa !2
  br label %742

742:                                              ; preds = %745, %737
  %743 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i121 = getelementptr inbounds i8, i8* %0, i64 %743
  %744 = load i8, i8* %arrayidx.i121, align 1, !tbaa !6
  %.not8 = icmp eq i8 %744, 0
  br i1 %.not8, label %758, label %745

745:                                              ; preds = %742
  %746 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i120 = add i64 %746, -1
  store i64 %add.i120, i64* %ptr, align 8, !tbaa !2
  %747 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i119 = add i64 %747, -1
  store i64 %add.i119, i64* %ptr, align 8, !tbaa !2
  %748 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i118 = add i64 %748, -1
  store i64 %add.i118, i64* %ptr, align 8, !tbaa !2
  %749 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i117 = add i64 %749, -1
  store i64 %add.i117, i64* %ptr, align 8, !tbaa !2
  %750 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i115 = getelementptr inbounds i8, i8* %0, i64 %750
  %751 = load i8, i8* %arrayidx.i115, align 1, !tbaa !6
  %add.i116 = add i8 %751, 1
  store i8 %add.i116, i8* %arrayidx.i115, align 1, !tbaa !6
  %752 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i114 = add i64 %752, 1
  store i64 %add.i114, i64* %ptr, align 8, !tbaa !2
  %753 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i113 = add i64 %753, 1
  store i64 %add.i113, i64* %ptr, align 8, !tbaa !2
  %754 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i112 = add i64 %754, 1
  store i64 %add.i112, i64* %ptr, align 8, !tbaa !2
  %755 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i111 = add i64 %755, 1
  store i64 %add.i111, i64* %ptr, align 8, !tbaa !2
  %756 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i109 = getelementptr inbounds i8, i8* %0, i64 %756
  %757 = load i8, i8* %arrayidx.i109, align 1, !tbaa !6
  %add.i110 = add i8 %757, -1
  store i8 %add.i110, i8* %arrayidx.i109, align 1, !tbaa !6
  br label %742

758:                                              ; preds = %742
  %759 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i108 = add i64 %759, -1
  store i64 %add.i108, i64* %ptr, align 8, !tbaa !2
  %760 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i106 = getelementptr inbounds i8, i8* %0, i64 %760
  %761 = load i8, i8* %arrayidx.i106, align 1, !tbaa !6
  %add.i107 = add i8 %761, -1
  store i8 %add.i107, i8* %arrayidx.i106, align 1, !tbaa !6
  br label %.loopexit35

.loopexit35.loopexit:                             ; preds = %780
  br label %.loopexit35

.loopexit35:                                      ; preds = %.loopexit35.loopexit, %758
  %762 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i105 = getelementptr inbounds i8, i8* %0, i64 %762
  %763 = load i8, i8* %arrayidx.i105, align 1, !tbaa !6
  %.not9 = icmp eq i8 %763, 0
  br i1 %.not9, label %777, label %764

764:                                              ; preds = %.loopexit35
  %765 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i104 = add i64 %765, 1
  store i64 %add.i104, i64* %ptr, align 8, !tbaa !2
  %766 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i103 = add i64 %766, 1
  store i64 %add.i103, i64* %ptr, align 8, !tbaa !2
  %767 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i98 = getelementptr inbounds i8, i8* %0, i64 %767
  %768 = load i8, i8* %arrayidx.i98, align 1, !tbaa !6
  %conv.i99 = zext i8 %768 to i32
  %769 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i100 = call i32 @putc(i32 %conv.i99, %struct._IO_FILE* %769) #9
  %770 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i97 = add i64 %770, 1
  store i64 %add.i97, i64* %ptr, align 8, !tbaa !2
  %771 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i94 = getelementptr inbounds i8, i8* %0, i64 %771
  %772 = load i8, i8* %arrayidx.i94, align 1, !tbaa !6
  %conv.i = zext i8 %772 to i32
  %773 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8, !tbaa !7
  %call.i.i = call i32 @putc(i32 %conv.i, %struct._IO_FILE* %773) #9
  %774 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i93 = add i64 %774, -1
  store i64 %add.i93, i64* %ptr, align 8, !tbaa !2
  %775 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i92 = add i64 %775, -1
  store i64 %add.i92, i64* %ptr, align 8, !tbaa !2
  %776 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i91 = add i64 %776, -1
  store i64 %add.i91, i64* %ptr, align 8, !tbaa !2
  br label %780

777:                                              ; preds = %.loopexit35
  %778 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i90 = add i64 %778, -1
  store i64 %add.i90, i64* %ptr, align 8, !tbaa !2
  %779 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i89 = add i64 %779, -1
  store i64 %add.i89, i64* %ptr, align 8, !tbaa !2
  br label %786

780:                                              ; preds = %783, %764
  %781 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i88 = getelementptr inbounds i8, i8* %0, i64 %781
  %782 = load i8, i8* %arrayidx.i88, align 1, !tbaa !6
  %.not14 = icmp eq i8 %782, 0
  br i1 %.not14, label %.loopexit35.loopexit, label %783

783:                                              ; preds = %780
  %784 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i86 = getelementptr inbounds i8, i8* %0, i64 %784
  %785 = load i8, i8* %arrayidx.i86, align 1, !tbaa !6
  %add.i87 = add i8 %785, -1
  store i8 %add.i87, i8* %arrayidx.i86, align 1, !tbaa !6
  br label %780

786:                                              ; preds = %789, %777
  %787 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i85 = getelementptr inbounds i8, i8* %0, i64 %787
  %788 = load i8, i8* %arrayidx.i85, align 1, !tbaa !6
  %.not10 = icmp eq i8 %788, 0
  br i1 %.not10, label %802, label %789

789:                                              ; preds = %786
  %790 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i84 = add i64 %790, 1
  store i64 %add.i84, i64* %ptr, align 8, !tbaa !2
  %791 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i83 = add i64 %791, 1
  store i64 %add.i83, i64* %ptr, align 8, !tbaa !2
  %792 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i81 = getelementptr inbounds i8, i8* %0, i64 %792
  %793 = load i8, i8* %arrayidx.i81, align 1, !tbaa !6
  %add.i82 = add i8 %793, 1
  store i8 %add.i82, i8* %arrayidx.i81, align 1, !tbaa !6
  %794 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i80 = add i64 %794, 1
  store i64 %add.i80, i64* %ptr, align 8, !tbaa !2
  %795 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i78 = getelementptr inbounds i8, i8* %0, i64 %795
  %796 = load i8, i8* %arrayidx.i78, align 1, !tbaa !6
  %add.i79 = add i8 %796, 1
  store i8 %add.i79, i8* %arrayidx.i78, align 1, !tbaa !6
  %797 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i77 = add i64 %797, -1
  store i64 %add.i77, i64* %ptr, align 8, !tbaa !2
  %798 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i76 = add i64 %798, -1
  store i64 %add.i76, i64* %ptr, align 8, !tbaa !2
  %799 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i75 = add i64 %799, -1
  store i64 %add.i75, i64* %ptr, align 8, !tbaa !2
  %800 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i73 = getelementptr inbounds i8, i8* %0, i64 %800
  %801 = load i8, i8* %arrayidx.i73, align 1, !tbaa !6
  %add.i74 = add i8 %801, -1
  store i8 %add.i74, i8* %arrayidx.i73, align 1, !tbaa !6
  br label %786

802:                                              ; preds = %786
  %803 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i72 = add i64 %803, 1
  store i64 %add.i72, i64* %ptr, align 8, !tbaa !2
  %804 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i71 = add i64 %804, 1
  store i64 %add.i71, i64* %ptr, align 8, !tbaa !2
  %805 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i70 = add i64 %805, 1
  store i64 %add.i70, i64* %ptr, align 8, !tbaa !2
  br label %806

806:                                              ; preds = %809, %802
  %807 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i69 = getelementptr inbounds i8, i8* %0, i64 %807
  %808 = load i8, i8* %arrayidx.i69, align 1, !tbaa !6
  %.not11 = icmp eq i8 %808, 0
  br i1 %.not11, label %820, label %809

809:                                              ; preds = %806
  %810 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i68 = add i64 %810, -1
  store i64 %add.i68, i64* %ptr, align 8, !tbaa !2
  %811 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i67 = add i64 %811, -1
  store i64 %add.i67, i64* %ptr, align 8, !tbaa !2
  %812 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i66 = add i64 %812, -1
  store i64 %add.i66, i64* %ptr, align 8, !tbaa !2
  %813 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i64 = getelementptr inbounds i8, i8* %0, i64 %813
  %814 = load i8, i8* %arrayidx.i64, align 1, !tbaa !6
  %add.i65 = add i8 %814, 1
  store i8 %add.i65, i8* %arrayidx.i64, align 1, !tbaa !6
  %815 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i63 = add i64 %815, 1
  store i64 %add.i63, i64* %ptr, align 8, !tbaa !2
  %816 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i62 = add i64 %816, 1
  store i64 %add.i62, i64* %ptr, align 8, !tbaa !2
  %817 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i61 = add i64 %817, 1
  store i64 %add.i61, i64* %ptr, align 8, !tbaa !2
  %818 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i59 = getelementptr inbounds i8, i8* %0, i64 %818
  %819 = load i8, i8* %arrayidx.i59, align 1, !tbaa !6
  %add.i60 = add i8 %819, -1
  store i8 %add.i60, i8* %arrayidx.i59, align 1, !tbaa !6
  br label %806

820:                                              ; preds = %806
  %821 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i58 = add i64 %821, -1
  store i64 %add.i58, i64* %ptr, align 8, !tbaa !2
  %822 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i57 = add i64 %822, -1
  store i64 %add.i57, i64* %ptr, align 8, !tbaa !2
  br label %823

823:                                              ; preds = %826, %820
  %824 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i56 = getelementptr inbounds i8, i8* %0, i64 %824
  %825 = load i8, i8* %arrayidx.i56, align 1, !tbaa !6
  %.not12 = icmp eq i8 %825, 0
  br i1 %.not12, label %833, label %826

826:                                              ; preds = %823
  %827 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i55 = add i64 %827, -1
  store i64 %add.i55, i64* %ptr, align 8, !tbaa !2
  %828 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i53 = getelementptr inbounds i8, i8* %0, i64 %828
  %829 = load i8, i8* %arrayidx.i53, align 1, !tbaa !6
  %add.i54 = add i8 %829, 1
  store i8 %add.i54, i8* %arrayidx.i53, align 1, !tbaa !6
  %830 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i52 = add i64 %830, 1
  store i64 %add.i52, i64* %ptr, align 8, !tbaa !2
  %831 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i50 = getelementptr inbounds i8, i8* %0, i64 %831
  %832 = load i8, i8* %arrayidx.i50, align 1, !tbaa !6
  %add.i51 = add i8 %832, -1
  store i8 %add.i51, i8* %arrayidx.i50, align 1, !tbaa !6
  br label %823

833:                                              ; preds = %823
  %834 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i49 = add i64 %834, 1
  store i64 %add.i49, i64* %ptr, align 8, !tbaa !2
  br label %835

835:                                              ; preds = %838, %833
  %836 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i48 = getelementptr inbounds i8, i8* %0, i64 %836
  %837 = load i8, i8* %arrayidx.i48, align 1, !tbaa !6
  %.not13 = icmp eq i8 %837, 0
  br i1 %.not13, label %845, label %838

838:                                              ; preds = %835
  %839 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i47 = add i64 %839, -1
  store i64 %add.i47, i64* %ptr, align 8, !tbaa !2
  %840 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i45 = getelementptr inbounds i8, i8* %0, i64 %840
  %841 = load i8, i8* %arrayidx.i45, align 1, !tbaa !6
  %add.i46 = add i8 %841, 1
  store i8 %add.i46, i8* %arrayidx.i45, align 1, !tbaa !6
  %842 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i44 = add i64 %842, 1
  store i64 %add.i44, i64* %ptr, align 8, !tbaa !2
  %843 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i42 = getelementptr inbounds i8, i8* %0, i64 %843
  %844 = load i8, i8* %arrayidx.i42, align 1, !tbaa !6
  %add.i43 = add i8 %844, -1
  store i8 %add.i43, i8* %arrayidx.i42, align 1, !tbaa !6
  br label %835

845:                                              ; preds = %835
  %846 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i41 = add i64 %846, -1
  store i64 %add.i41, i64* %ptr, align 8, !tbaa !2
  %847 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i40 = add i64 %847, -1
  store i64 %add.i40, i64* %ptr, align 8, !tbaa !2
  %848 = load i64, i64* %ptr, align 8, !tbaa !2
  %add.i39 = add i64 %848, -1
  store i64 %add.i39, i64* %ptr, align 8, !tbaa !2
  %849 = load i64, i64* %ptr, align 8, !tbaa !2
  %arrayidx.i37 = getelementptr inbounds i8, i8* %0, i64 %849
  %850 = load i8, i8* %arrayidx.i37, align 1, !tbaa !6
  %add.i38 = add i8 %850, -1
  store i8 %add.i38, i8* %arrayidx.i37, align 1, !tbaa !6
  br label %190
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
