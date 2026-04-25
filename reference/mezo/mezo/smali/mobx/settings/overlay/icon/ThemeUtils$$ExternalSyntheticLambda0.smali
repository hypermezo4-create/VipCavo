# classes10.dex

.class public final synthetic Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/function/Function;


# static fields
.field public static final synthetic INSTANCE:Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda0;


# direct methods
.method static synthetic constructor <clinit>()V
    .registers 1

    new-instance v0, Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda0;-><init>()V

    sput-object v0, Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda0;->INSTANCE:Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda0;

    return-void
.end method

.method private synthetic constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 2

    check-cast p1, Landroid/content/om/OverlayInfo;

    invoke-static {p1}, Lmobx/settings/overlay/icon/ThemeUtils;->lambda$setOverlayEnabled$2(Landroid/content/om/OverlayInfo;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method
