module Top (
    input wire Clock,
    input wire Reset,
    input wire Start,
    input wire Stop,
    output wire [3:0] count
);

    wire enable;

    FSM fsm_instance (
        .Clock(Clock),
        .Reset(Reset),
        .Start(Start),
        .Stop(Stop),
        .enable(enable)
    );

    q42 datapath_instance (
        .Clock(Clock),
        .Reset(Reset),
        .enable(enable),
        .count(count)
    );

endmodule