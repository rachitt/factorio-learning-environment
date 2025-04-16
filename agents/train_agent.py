# agents/null_agent.py

from agents.agent_abc import AgentABC

class NullAgent(AgentABC):
    def __init__(self, env, **kwargs):
        self.env = env

    def act(self, obs):
        # Minimal logic — could be a fixed or random action
        action = (0,4,0)
        return action
